<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Finance Tracker | Home</title>
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            font-family: 'Segoe UI', sans-serif;
            height: 100vh; display: flex; align-items: center; justify-content: center; margin: 0;
        }
        .card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(15px);
            padding: 50px; border-radius: 20px; border: 1px solid rgba(255, 255, 255, 0.2);
            text-align: center; color: white;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
        }
        .btn {
            display: inline-block; padding: 15px 30px; background: white; color: #764ba2;
            text-decoration: none; border-radius: 10px; font-weight: bold; margin-top: 20px;
            transition: 0.3s;
        }
        .btn:hover { transform: translateY(-3px); box-shadow: 0 5px 15px rgba(0,0,0,0.2); }
    </style>
</head>
<body>
<div class="card">
    <h1>Mirësevini Jusila!</h1>
    <p>Menaxhoni financat tuaja në mënyrë të thjeshtë.</p>
    <a href="transactions" class="btn">Shiko Transaksionet</a>
</div>
</body>
</html>