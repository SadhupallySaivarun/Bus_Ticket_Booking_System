<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>CodeWare - Passenger Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f1f1f1;
            padding: 40px;
        }

        .container {
            background-color: #fff;
            padding: 30px;
            max-width: 600px;
            margin: auto;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.2);
        }

        h2 {
            color: #0033cc;
        }

        input, select {
            width: 100%;
            padding: 10px;
            margin: 8px 0 20px 0;
            display: inline-block;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .btn {
            background-color: #0033cc;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 5px;
            font-weight: bold;
            cursor: pointer;
        }

        .btn:hover {
            background-color: #005ce6;
        }

        #progress {
            display: none;
            text-align: center;
        }

        .modal {
            display: none;
            position: fixed;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            text-align: center;
        }
    </style>
</head>
<body>

<%-- Use the request parameters directly without redeclaring them --%>
<div class="container">
    <h2>Passenger Details</h2>

    <form action="finalizeBooking.jsp" method="post">
        <!-- Hidden Fields to Forward Data -->
        <input type="hidden" name="selectedSeats" value="<%= request.getParameter("selectedSeats") %>">
        <input type="hidden" name="totalFare" value="<%= request.getParameter("totalFare") %>">
        <input type="hidden" name="boarding" value="<%= request.getParameter("boarding") %>">

        <label for="fullName">Full Name:</label>
        <input type="text" name="fullName" id="fullName" value="<%= request.getParameter("fullName") != null ? request.getParameter("fullName") : "" %>" required>

        <label for="age">Age:</label>
        <input type="number" name="age" id="age" value="<%= request.getParameter("age") != null ? request.getParameter("age") : "" %>" required>

        <label for="gender">Gender:</label>
        <select name="gender" id="gender" required>
            <option value="" disabled selected>Select Gender</option>
            <option value="Male" <%= "Male".equals(request.getParameter("gender")) ? "selected" : "" %>>Male</option>
            <option value="Female" <%= "Female".equals(request.getParameter("gender")) ? "selected" : "" %>>Female</option>
            <option value="Other" <%= "Other".equals(request.getParameter("gender")) ? "selected" : "" %>>Other</option>
        </select>

        <label for="email">Email:</label>
        <input type="email" name="email" id="email" value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>" required>

        <label for="phone">Phone Number:</label>
        <input type="text" name="phone" id="phone" value="<%= request.getParameter("phone") != null ? request.getParameter("phone") : "" %>" required>

        <button type="submit" class="btn" id="confirmBtn">Confirm Booking</button>
    </form>
</div>

<!-- Progress Spinner -->
<div id="progress">
    <img src="spinner.gif" alt="Processing..." />
    <p>Processing your booking...</p>
</div>

<!-- Confirmation Modal -->
<div id="confirmModal" class="modal">
    <div class="modal-content">
        <h3>Please Confirm Your Details</h3>
        <p>Full Name: <span id="modalFullName"></span></p>
        <p>Age: <span id="modalAge"></span></p>
        <button onclick="submitForm()">Confirm</button>
        <button onclick="closeModal()">Cancel</button>
    </div>
</div>

<script>
    // Form submission handler
    document.querySelector('form').addEventListener('submit', function(e) {
        e.preventDefault();
        openModal();
    });

    // Open modal
    function openModal() {
        document.getElementById('modalFullName').textContent = document.getElementById('fullName').value;
        document.getElementById('modalAge').textContent = document.getElementById('age').value;
        document.getElementById('confirmModal').style.display = 'flex';
    }

    // Close modal
    function closeModal() {
        document.getElementById('confirmModal').style.display = 'none';
    }

    // Submit form after confirmation
    function submitForm() {
        document.querySelector('form').submit();
    }

    // Show progress indicator when form is being processed
    document.querySelector('form').addEventListener('submit', function() {
        document.getElementById('progress').style.display = 'block';
    });
</script>

</body>
</html>
