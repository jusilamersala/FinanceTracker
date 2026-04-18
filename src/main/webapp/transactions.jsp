<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Finance Tracker | Dashboard</title>
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            font-family: 'Segoe UI', sans-serif;
            display: flex; flex-direction: column; align-items: center; padding: 50px; color: white; margin: 0;
            min-height: 100vh;
        }
        .glass-panel {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 20px; padding: 30px; width: 85%; max-width: 1000px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
            margin-bottom: 30px;
        }
        .input-group { display: flex; gap: 15px; flex-wrap: wrap; margin-top: 20px; }
        input, select {
            background: rgba(255, 255, 255, 0.2);
            border: 1px solid rgba(255, 255, 255, 0.3);
            padding: 12px; border-radius: 10px; color: white; outline: none; flex: 1;
            min-width: 150px;
        }
        input::placeholder { color: rgba(255, 255, 255, 0.7); }
        option { color: black; }
        .btn-save {
            background: #ffffff; color: #764ba2; border: none; padding: 12px 25px;
            border-radius: 10px; font-weight: bold; cursor: pointer; transition: 0.3s;
        }
        .btn-save:hover { background: #f0f0f0; transform: translateY(-2px); }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th { text-align: left; border-bottom: 2px solid rgba(255, 255, 255, 0.2); padding: 15px; }
        td { padding: 15px; border-bottom: 1px solid rgba(255, 255, 255, 0.1); }
        .income { color: #4ade80; font-weight: bold; text-transform: uppercase; font-size: 0.8rem; }
        .expense { color: #f87171; font-weight: bold; text-transform: uppercase; font-size: 0.8rem; }
        .back-link { color: white; text-decoration: none; font-size: 0.9rem; opacity: 0.7; margin-bottom: 10px; display: inline-block; }
        .back-link:hover { opacity: 1; }
    </style>
</head>
<body>

<!-- DASHBOARD SUMMARY -->
<div class="glass-panel" style="display: flex; justify-content: space-around; text-align: center;">
    <div>
        <p style="opacity: 0.7; margin: 0;">Total Income</p>
        <h2 style="color: #4ade80; margin: 5px 0;">${totalIncome} €</h2>
    </div>
    <div>
        <p style="opacity: 0.7; margin: 0;">Total Expenses</p>
        <h2 style="color: #f87171; margin: 5px 0;">${totalExpenses} €</h2>
    </div>
    <div>
        <p style="opacity: 0.7; margin: 0;">Balance</p>
        <h2 style="color: white; margin: 5px 0;">${balance} €</h2>
    </div>
</div>

<div class="glass-panel">
    <a href="index.jsp" class="back-link">← Kthehu mbrapsht</a>
    <h2>Shto Transaksion</h2>
    <form action="transactions" method="POST">
        <div class="input-group">
            <input type="text" name="description" placeholder="Përshkrimi (p.sh. Market)" required>
            <input type="number" step="0.01" name="amount" placeholder="Shuma (€)" required>
            <input type="text" name="category" placeholder="Kategoria (p.sh. Ushqim)">
            <select name="type">
                <option value="EXPENSE">Shpenzim</option>
                <option value="INCOME">E ardhur</option>
            </select>
            <button type="submit" class="btn-save">Ruaj</button>
        </div>
    </form>
</div>

<div class="glass-panel">
    <h2>Historia e Financave</h2>
    <table>
        <thead>
        <tr>
            <th>Përshkrimi</th>
            <th>Shuma</th>
            <th>Kategoria</th>
            <th>Lloji</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="t" items="${transactionList}">
            <tr>
                <td>${t.description}</td>
                <td>${t.amount} €</td>
                <td>${t.category}</td>
                <td class="${t.type.toLowerCase()}">${t.type}</td>
            </tr>
        </c:forEach>
        <c:if test="${empty transactionList}">
            <tr>
                <td colspan="4" style="text-align: center; opacity: 0.5;">Nuk ka transaksione të regjistruara.</td>
            </tr>
        </c:if>
        </tbody>
    </table>
</div>

</body>
</html>