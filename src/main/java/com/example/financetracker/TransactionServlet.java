package com.example.financetracker;

import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/transactions")
public class TransactionServlet extends HttpServlet {

    @Inject
    private TransactionRepository repository;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("transactionList", repository.findAll());

        BigDecimal income = repository.getTotalIncome();
        BigDecimal expenses = repository.getTotalExpenses();
        BigDecimal balance = income.subtract(expenses);

        req.setAttribute("totalIncome", income);
        req.setAttribute("totalExpenses", expenses);
        req.setAttribute("balance", balance);

        req.getRequestDispatcher("/transactions.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String desc = req.getParameter("description");
        String amountStr = req.getParameter("amount");
        String type = req.getParameter("type");
        String category = req.getParameter("category");

        Transaction t = new Transaction();
        t.setDescription(desc);
        t.setAmount(new BigDecimal(amountStr));
        t.setType(type);
        t.setCategory(category);

        repository.save(t);
        resp.sendRedirect("transactions");
    }
}