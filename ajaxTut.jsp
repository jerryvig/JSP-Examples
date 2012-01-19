<%@ page import="com.mktneutral.GovAuctions" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%
   if ( request.getParameter("number") != null ) {
    if ( request.getParameter("number") != "" ) {
     if ( request.getParameter("searchString") != null ) {
      if ( request.getParameter("state") != null ) {
      
     String searchString = request.getParameter("searchString").trim();
     int number = Integer.parseInt(request.getParameter("number"));
     String state = request.getParameter("state").trim();

     GovAuctions govAuction = new GovAuctions();

     govAuction.runScrapers( searchString, number, state );
     
     Class.forName("org.hsqldb.jdbcDriver");
     Connection hsqldb = DriverManager.getConnection( "jdbc:hsqldb:file:govauctionsdb", "SA", "" );
     Statement stmt = hsqldb.createStatement();
  
     ResultSet countRS = stmt.executeQuery( "SELECT COUNT(*) FROM auction_records WHERE url<>'' AND results_content<>'' AND results_content IS NOT NULL" );
     countRS.next();
     int resultCount = countRS.getInt( 1 );
   
     String outString =  "{\"table\":[";
     
     if ( resultCount > 0 ) {
       ResultSet rs = stmt.executeQuery( "SELECT * FROM auction_records WHERE url<>'' AND results_content<>'' AND results_content IS NOT NULL ORDER BY website ASC" );   

       while ( rs.next() ) {
        outString += "{\"url\":\"" + rs.getString(2).trim() + "\",\"data\":\"" + rs.getString(3).trim() + "\"},"; 
       }
       outString = outString.substring( 0, outString.length()-1 );
       rs.close();
     }

     outString += "]}";

     out.print( outString );
     hsqldb.close();
      
      }
     }
    }
   }

%>