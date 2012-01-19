<%@ page import="java.io.BufferedReader" %><%@ page import="java.io.FileReader" %><html><head><script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script><script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.16/jquery-ui.min.js"></script><link rel="stylesheet" href="http://jqueryui.com/themes/base/jquery.ui.all.css"><script type="text/javascript">
$(window).load(function(){
   var urls = [ <% 
   BufferedReader inputReader = new BufferedReader( new FileReader("/root/Desktop/apache-tomcat-6.0.33/inputfile_sample.txt" ) );
   String s;
   while ( (s = inputReader.readLine()) != null ) {
     String[] row = s.split("\t");
     out.print( "\"" + row[0].trim() + "\", " ); 
   }
%> ];
   $("#textInput").autocomplete({ source:urls });
   $("#submitButton").button();
   $("#submitButton").click( function() {
     $("#resultsTable").empty();
     $("#spinner").attr("src","http://hipsterjesus.com/assets/images/ajax_spinner.gif");
     var myDiv = document.createElement('div');
     myDiv.setAttribute('style','font-weight:bold;color:#000000;');
     myDiv.appendChild( document.createTextNode("Searching...") );
     $("#captain").append( myDiv );
     var getString = "./admonitor.jsp?url=" + $("#textInput").val();
     $.get( getString, function(data) {  
       $("#resultsTable").append( "<tr style='background-color:#E0E0E0;'><th>Ad URL</th><th>File Name</th><th>File Type</th><th>Landing Page URL</th></tr>" );
       $("#resultsTable").append( data );
       $("#spinner").attr("src","http://curezone.com/upload/Members/new03/tn-white.jpg");
       $("#captain").empty();
     });
   });
});
</script></head><body><div align="center" class="ui-widget"><h2 style="background-color:#E0E0E0;color:#000000;">AdMonitor URL Entry</h2><br>
<div style='color:#000000;font-weight:bold;'>Enter a page URL:<input id="textInput"><input id="submitButton" type="submit" value="Get Ads"/></div><br><br><img src="http://curezone.com/upload/Members/new03/tn-white.jpg" id="spinner"></img>
<div id="captain"></div><table id="resultsTable" border="0" cellspacing="1" rules="none"></table></div></body></html>
