package com.example.financetracker;

import jakarta.enterprise.context.ApplicationScoped;
import java.sql.*;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@ApplicationScoped
public class TransactionRepository {

    private static final String URL = "jdbc:mysql://127.0.0.1:3306/finance_db?useSSL=false&allowPublicKeyRetrieval=true";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    private Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL driver not found", e);
        }
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    public List<Transaction> findAll() {
        List<Transaction> list = new ArrayList<>();
        String sql = "SELECT id, description, amount, type, category FROM transactions";
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Transaction t = new Transaction();
                t.setId(rs.getLong("id"));
                t.setDescription(rs.getString("description"));
                t.setAmount(rs.getBigDecimal("amount"));
                t.setType(rs.getString("type"));
                t.setCategory(rs.getString("category"));
                list.add(t);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Failed to fetch transactions: " + e.getMessage(), e);
        }
        return list;
    }

    public void save(Transaction t) {
        String sql = "INSERT INTO transactions (description, amount, type, category) VALUES (?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, t.getDescription());
            ps.setBigDecimal(2, t.getAmount());
            ps.setString(3, t.getType());
            ps.setString(4, t.getCategory());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Failed to save transaction: " + e.getMessage(), e);
        }
    }

    public BigDecimal getTotalIncome() {
        String sql = "SELECT COALESCE(SUM(amount), 0) FROM transactions WHERE type = 'INCOME'";
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) return rs.getBigDecimal(1);
        } catch (SQLException e) {
            throw new RuntimeException("Failed to get total income: " + e.getMessage(), e);
        }
        return BigDecimal.ZERO;
    }

    public BigDecimal getTotalExpenses() {
        String sql = "SELECT COALESCE(SUM(amount), 0) FROM transactions WHERE type = 'EXPENSE'";
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) return rs.getBigDecimal(1);
        } catch (SQLException e) {
            throw new RuntimeException("Failed to get total expenses: " + e.getMessage(), e);
        }
        return BigDecimal.ZERO;
    }
}