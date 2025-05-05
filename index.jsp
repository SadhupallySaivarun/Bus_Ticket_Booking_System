<%@ page import="java.sql.*" %> 
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>CodeWare - Bus Seat Booking</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f7f7;
            margin: 0;
            padding: 0;
        }

        .navbar {
            background-color: #ffffff;
            display: flex;
            justify-content: space-between;
            padding: 10px 40px;
            border-bottom: 2px solid #ccc;
        }

        .logo {
            font-size: 28px;
            color: #0033cc;
            font-weight: bold;
        }

        .nav-links li {
            display: inline-block;
            margin: 0 10px;
            font-weight: bold;
            color: #000;
            cursor: pointer;
        }

        .nav-links a {
            text-decoration: none;
            color: inherit;
        }

        .steps {
            display: flex;
            justify-content: center;
            background-color: #0033cc;
            color: white;
            font-weight: bold;
            padding: 10px;
        }

        .step {
            margin: 0 10px;
        }

        .active {
            background-color: #005ce6;
            padding: 5px 10px;
            border-radius: 5px;
        }

        .bus-option {
            background-color: white;
            margin: 20px auto;
            width: 90%;
            padding: 20px;
            border: 1px solid #aaa;
        }

        .bus-header {
            display: flex;
            justify-content: space-between;
            font-weight: bold;
            background-color: #e6f2ff;
            padding: 10px;
            border-bottom: 1px solid #ccc;
        }

        .view-seat-btn {
            background-color: red;
            color: white;
            padding: 5px 10px;
            border: none;
            border-radius: 5px;
            font-weight: bold;
        }

        .layout-section {
            display: flex;
            margin-top: 20px;
        }

        .seat-layout {
            display: grid;
            grid-template-columns: repeat(4, 50px);
            gap: 10px;
            margin-right: 40px;
        }

        .seat {
            width: 50px;
            height: 50px;
            text-align: center;
            line-height: 50px;
            border-radius: 5px;
            color: white;
            font-weight: bold;
            cursor: pointer;
        }

        .green { background-color: green; }
        .red { background-color: red; cursor: not-allowed; }
        .yellow { background-color: yellow; color: black; }

        .legend {
            margin: 20px 0;
        }

        .legend span {
            display: inline-block;
            width: 20px;
            height: 20px;
            margin-right: 5px;
            border-radius: 3px;
        }

        .seat-details {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        .seat-details th, .seat-details td {
            border: 1px solid #aaa;
            padding: 8px;
            text-align: center;
        }

        .summary {
            max-width: 300px;
        }

        .continue-btn {
            background-color: #0033cc;
            color: white;
            border: none;
            padding: 10px 20px;
            font-weight: bold;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
        }

        select {
            width: 100%;
            padding: 5px;
            margin-bottom: 10px;
        }

        .engine {
            grid-column: span 4;
            background-color: #333;
            color: white;
            text-align: center;
            padding: 5px;
            margin-top: 10px;
        }
    </style>
</head>
<body>

<div class="navbar">
    <div class="logo">CODEWARE</div>
    <ul class="nav-links">
        <!-- Add href links to make these buttons functional -->
        <li><a href="index.jsp">Home</a></li>
        <li><a href="about.jsp">About Us</a></li>
        <li><a href="download.jsp">Download Ticket</a></li>
        <li><a href="contact.jsp">Contact Us</a></li>
    </ul>
</div>

<div class="steps">
    <div class="step active">1 Select Route & Schedule</div>
    <div class="step active">2 Book Seat</div>
    <div class="step">3 Passenger Details</div>
    <div class="step">4 Payment</div>
    <div class="step">5 Download Ticket</div>
</div>

<div class="bus-option">
    <div class="bus-header">
        <div>
            <div>Operator: CodeWare Express</div>
            <div>CD-111 - Business - AC</div>
            <div>MAN Germany</div>
        </div>
        <div>
            <div>Dep. Time: 20:00</div>
            <div>Seat Available: 28</div>
            <div>Fare: BDT 1000.00</div>
            <button class="view-seat-btn">View Seat</button>
        </div>
    </div>

    <div class="layout-section">
        <!-- Seat layout -->
        <div>
            <div class="seat-layout">
                <%-- Yellow = Selected, Green = Available, Red = Booked --%>
                <% for(char row='A'; row<='I'; row++) {
                    for(int col=1; col<=2; col++) {
                        String seatId = row + String.valueOf(col);
                %>
                    <div class="seat green"><%= seatId %></div>
                <%  } } %>
                <div class="engine">Engine</div>
            </div>

            <div class="legend">
                <span class="green"></span> Available Seat
                <span class="red"></span> Booked Seat
                <span class="yellow"></span> Selected Seat
            </div>
        </div>

        <!-- Summary & Boarding -->
        <div class="summary">
            <form id="bookingForm" action="payment.jsp" method="post">
                <table class="seat-details">
                    <thead>
                        <tr>
                            <th>Seat</th>
                            <th>Fare</th>
                            <th>Class</th>
                            <th>Remove</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Rows dynamically inserted -->
                    </tbody>
                    <tfoot>
                        <tr><td colspan="4" style="text-align:right"><strong>Total: 0.00</strong></td></tr>
                    </tfoot>
                </table>

                <label for="boarding">Boarding Point *</label>
                <select id="boarding" name="boarding" required>
                    <option value="kallyanpur">Kallyanpur - 20:00</option>
                    <option value="gabtoli">Gabtoli - 20:30</option>
                </select>

                <!-- Hidden inputs to send selected seat data -->
                <input type="hidden" id="selectedSeatsInput" name="selectedSeats">
                <input type="hidden" id="totalFareInput" name="totalFare">

                <button class="continue-btn" type="submit" disabled>Continue</button>
            </form>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", () => {
        const seats = document.querySelectorAll(".seat.green, .seat.yellow");
        const summaryTable = document.querySelector(".seat-details tbody");
        const continueBtn = document.querySelector(".continue-btn");
        const totalRow = document.querySelector(".seat-details tfoot tr");
        const selectedSeatsInput = document.getElementById("selectedSeatsInput");
        const totalFareInput = document.getElementById("totalFareInput");

        const seatFare = 1000;
        const selectedSeats = new Set();

        function updateSummaryTable() {
            summaryTable.innerHTML = "";

            selectedSeats.forEach(seat => {
                const row = document.createElement("tr");
                row.innerHTML = `
                    <td>${seat}</td>
                    <td>${seatFare.toFixed(2)}</td>
                    <td>Business</td>
                    <td class="cancel-btn" style="cursor:pointer">? Cancel</td>
                `;
                summaryTable.appendChild(row);
            });

            const total = selectedSeats.size * seatFare;
            totalRow.innerHTML = `<td colspan="4" style="text-align:right"><strong>Total: ${total.toFixed(2)}</strong></td>`;
            continueBtn.disabled = selectedSeats.size === 0;

            // Update hidden inputs
            selectedSeatsInput.value = Array.from(selectedSeats).join(",");
            totalFareInput.value = total.toFixed(2);
        }

        seats.forEach(seat => {
            seat.addEventListener("click", () => {
                const seatNumber = seat.textContent.trim();
                if (seat.classList.contains("yellow")) {
                    seat.classList.remove("yellow");
                    seat.classList.add("green");
                    selectedSeats.delete(seatNumber);
                } else if (seat.classList.contains("green")) {
                    seat.classList.remove("green");
                    seat.classList.add("yellow");
                    selectedSeats.add(seatNumber);
                }
                updateSummaryTable();
            });
        });

        summaryTable.addEventListener("click", e => {
            if (e.target.classList.contains("cancel-btn")) {
                const seat = e.target.parentElement.firstElementChild.textContent.trim();
                selectedSeats.delete(seat);
                seats.forEach(s => {
                    if (s.textContent.trim() === seat) {
                        s.classList.remove("yellow");
                        s.classList.add("green");
                    }
                });
                updateSummaryTable();
            }
        });
    });
</script>

</body>
</html>
