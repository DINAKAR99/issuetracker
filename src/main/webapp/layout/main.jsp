<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
  <%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
      <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
          <!DOCTYPE html>
          <html>

          <head>
            <meta charset="UTF-8" />
            <meta charset="ISO-8859-1" />
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />
            <meta name="description"
              content="Telangana State Building Permission Approval and Self certification System" />
            <meta name="keywords"
              content="Telangana State Building Permission Approval and Self certification System" />
            <script src="https://code.jquery.com/jquery-3.7.1.js"
              integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
            <link href="${pageContext.request.contextPath}/css/font-awesome.min.css" rel="stylesheet" />
            <link href="${pageContext.request.contextPath}/css/custom.css" rel="stylesheet" />
            <link href="${pageContext.request.contextPath}/css/sm-core-css.css" rel="stylesheet" />
            <link href="${pageContext.request.contextPath}/css/sm-blue.css" rel="stylesheet" />
            <link href="https://code.jquery.com/ui/1.10.4/themes/ui-lightness/jquery-ui.css" rel="stylesheet" />
            <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@200;400;500;700&display=swap"
              rel="stylesheet" />
            <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js"></script>
            <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
            <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
            <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
            <title>Ticketing System</title>
            <link href="${pageContext.request.contextPath}/css/main.css" rel="stylesheet">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font-awesome.min.css">
            <link href="${pageContext.request.contextPath}/css/custom.css" rel="stylesheet">
            <link href="${pageContext.request.contextPath}/css/sm-core-css.css" rel="stylesheet">
            <link href="${pageContext.request.contextPath}/css/sm-blue.css" rel="stylesheet">
            <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@200;400;500;700&display=swap"
              rel="stylesheet">
            <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
            <!-- jQuery and DataTables JS -->
            <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script> -->
            <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
            <script src="https://cdn.datatables.net/buttons/2.2.3/js/dataTables.buttons.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
            <script src="https://cdn.datatables.net/buttons/2.2.3/js/buttons.html5.min.js"></script>
            <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/tg.png">
          </head>

          <body>
            <tiles:insertAttribute name="header"></tiles:insertAttribute>
            <tiles:insertAttribute name="menu"></tiles:insertAttribute>
            <div>
              <div style=" min-height: 80vh;overflow-y: hidden ;">
                <tiles:insertAttribute name="content"></tiles:insertAttribute>
              </div>
            </div>
            <tiles:insertAttribute name="footer"></tiles:insertAttribute>
            <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
            <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
            <script src="
            https://cdn.jsdelivr.net/npm/jquery-validation@1.21.0/dist/jquery.validate.min.js
            "></script>
            <!-- <script src="${pageContext.request.contextPath}/js/jquery.js"></script> -->
            <script src="${pageContext.request.contextPath}/js/popper.min.js"></script>
            <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
            <script src="${pageContext.request.contextPath}/js/fontsizer.js"></script>
            <!-- SmartMenus jQuery plugin -->
            <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.smartmenus.js"></script>
            <script type="text/javascript" src="${pageContext.request.contextPath}/js/sm-menu.js"></script>
          </body>

          </html>