<%@ page import="com.mktneutral.AdMonitor" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.SQLException" %>
<%
  if ( request.getParameter("url") != null ) { 
     String[] args = { request.getParameter("url").trim() };    
     AdMonitor.main( args );
     Class.forName("org.hsqldb.jdbcDriver");
     Connection conn = DriverManager.getConnection("jdbc:hsqldb:file:admonitor", "SA", "" );
     //Statement stmt = conn.createStatement();
     //ResultSet rsCount = stmt.executeQuery( "SELECT COUNT(*) FROM ad_urls AS t1 LEFT OUTER JOIN landing_page_urls AS t2 ON t2.ad_url=t1.url_string" );
     //rsCount.next();
     //out.println( "count = " +  rsCount.getString(1) + "<br>" );
     //rsCount.close();
      
     //ResultSet rs = stmt.executeQuery( "SELECT * FROM landing_page_urls ORDER BY file_name ASC" );
     ResultSet rs = conn.createStatement().executeQuery("SELECT DISTINCT t1.*, t2.landing_page_url FROM ad_urls AS t1 LEFT OUTER JOIN landing_page_urls AS t2 ON ( t2.ad_url=t1.url_string ) ORDER BY t1.file_name ASC");
     int rowCount = 0;
     while ( rs.next() ) {
       String url = rs.getString(1).trim();
       String fileName = rs.getString(2).trim();
       String type = rs.getString(3).trim();
       String landingPageUrl = "NULL";
       try {
          landingPageUrl = rs.getString(4).trim();
       } catch ( NullPointerException npe ) { npe.printStackTrace(); }
       catch ( SQLException sqle ) { sqle.printStackTrace(); }
      
       if ( rowCount%2 == 1 ) {
         out.println( "<tr style='background-color:#E0E0E0;color:#000000;font-weight:bold;'><td><a href='" + url + "' target='blank'>" + url + "</a></td><td><a href='./DL/"+fileName+"'>"+fileName+"</a></td><td>"+type+"</td><td><a href='" + landingPageUrl + "' target='blank'>" + landingPageUrl + "</a></td></tr>" );
       }
       else {
        out.println( "<tr style='background-color:#A0CFEC;color:#000000;font-weight:bold;'><td><a href='" + url + "' target='blank'>" + url + "</a></td><td><a href='./DL/"+fileName+"'>"+fileName+"</a></td><td>"+type+"</td><td><a href='" + landingPageUrl + "' target='blank'>" + landingPageUrl + "</a></td></tr>" );
       }
       rowCount++;
     }
     conn.close();         
  }
  else {
     out.println( "<html><body><h1>You need to enter a URL for processing.</h1></body></html>" );
  }
%>