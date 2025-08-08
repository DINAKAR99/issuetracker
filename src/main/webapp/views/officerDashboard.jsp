<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
            <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

                <% String path=request.getContextPath(); String basePath=request.getScheme() + "://" +
                    request.getServerName() + ":" + request.getServerPort() + path + "/" ; %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Card Layout</title>
    <style>
        .card-container {
            display: flex;
            justify-content: space-between;
            gap: 20px;
            padding: 20px;
        }

        .card {
            width: 22%;
            height: 200px;
            padding: 20px;
            text-align: center;
            border-radius: 8px;
            color: white;
            font-size: 18px;
        }

        .card1 {
            background-color: #FF6347;
            /* Tomato */
        }

        .card2 {
            background-color: #4682B4;
            /* SteelBlue */
        }

        .card3 {
            background-color: #32CD32;
            /* LimeGreen */
        }

        .card4 {
            background-color: #FFD700;
            /* Gold */
        }
    </style>
</head>

<body>
     <div  class="card-container p-5 m-5  shadow-lg" >
        <div class="card card1 shadow-lg"><h1 style="font-size:20px !important;" class="card-title my-5"><i class="fa fa-envelope-open" aria-hidden="true"></i> Total Received
        <br><a  href="javascript:void(0)"   onclick="fecthReport('total')" style="text-decoration: underline;color: white;font-size:50px !important;"> ${Total}</a>
        </h1></div>
        <div class="card card2 shadow-lg"><h1 style="font-size:20px !important;" class="card-title my-5"><i class="fa fa-ticket" aria-hidden="true"></i> Total Pending
        <br><a href="javascript:void(0)" onclick="fecthReport('pending')"
            style="text-decoration: underline;color: white;font-size:50px !important;">${forwarded+Inprogress+open+hold}</a>
        </h1></div>
        <div class="card card3 shadow-lg"><h1 style="font-size:20px !important;" class="card-title mt-5"><i class="fa fa-share" aria-hidden="true"></i> Total Closed
        <br>
        <c:if test="${empty closed }" ><span style="text-decoration: underline;color: white;font-size:50px !important;">0</span></c:if>
        <c:if test="${not empty closed}">
            <a href="javascript:void(0)" onclick="fecthReport('closed')"
            style="text-decoration: underline;color: white;font-size:50px !important;">
            ${closed + rejected}
        </a>
    </c:if>
        </h1></div>
         
    </div>

    <script>
         function fecthReport(status) { 
                var myForm = document.createElement("form");
                myForm.setAttribute("method", "post");
                myForm.setAttribute("action", "${pageContext.request.contextPath}/mainReport"); 
                var token = $('#_csrf').attr('content');
                var csrfField = document.createElement("input");
                csrfField.setAttribute("type", "hidden");
                csrfField.setAttribute("name", "_csrf");
                csrfField.setAttribute("value", token);
                myForm.appendChild(csrfField); 
                //setting status in input 
                    var customizedField = document.createElement("input");
                    customizedField.setAttribute("type", "hidden");
                    customizedField.setAttribute("name", "status");
                    customizedField.setAttribute("value",  status);
                    myForm.appendChild(customizedField); 
                document.body.appendChild(myForm); 
                myForm.submit();
                return false;

            }
    </script>
 </body>



</html>