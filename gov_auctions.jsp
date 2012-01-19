<META name="robots" content="noindex, nofollow"/><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">
<title>Auction Resource - Auction Resource</title>
<meta NAME="Keywords" Content="Auction Resource">
<meta NAME="Description" Content="Auction Resource - Your #1 Source for Finding Seized, Surplus and Unclaimed Property From the U.S. Marshalls, FBI, IRS, DEA, U.S. Customs as well as 1000's of Federal, State and Local Agencies">
<link type="text/css" rel="stylesheet" href="http://auctionresource.org/xsp_styles.css">
<META name="robots" content="noindex, nofollow"/>

<script src="http://yui.yahooapis.com/3.4.0/build/yui/yui-min.js"></script>
<link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/combo?2.9.0/build/progressbar/assets/skins/sam/progressbar.css">
<link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.9.0/build/button/assets/skins/sam/button.css">
<script type="text/javascript" src="http://yui.yahooapis.com/combo?2.9.0/build/yahoo-dom-event/yahoo-dom-event.js&2.9.0/build/element/element-min.js&2.9.0/build/progressbar/progressbar-min.js"></script>
<script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/button/button-min.js"></script>

<script type="text/javascript">
 var progressBar = null;
 window.onload = function() {
   progressBar = new YAHOO.widget.ProgressBar();
   progressBar.set("height","30px");
   progressBar.set("width","200px");
   progressBar.render("pbContainer");
   progressBar.set('value',0);
  
   var stopButton = new YAHOO.widget.Button({label:"Stop Search",id:"stopSearchButton",container:"stopButtonContainer"});
   stopButton.on("click",stopSearch);
   var submitButton = new YAHOO.widget.Button({label:"Search",id:"submitButton",container:"submitButtonContainer"});
   submitButton.on("click",doSearch);
   var newSearchButton = new YAHOO.widget.Button({label:"New Search",id:"newSearchButton",container:"newSearchContainer"});
   newSearchButton.on("click",clearResults);
 }

 function incrementHiddenVal() {
   var hiddenValue = document.getElementById("hiddenValue").value;
   document.getElementById("hiddenValue").value = hiddenValue*1.0 + 1.0; }

 function stopSearch(){
   document.getElementById("hiddenValue").value = 999.0*1.0;
   document.getElementById("currentEngineDiv").replaceChild( document.createTextNode("Search Complete."), currentEngineDiv.firstChild );
   document.getElementById("spinnerImg").setAttribute("src","http://curezone.com/upload/Members/new03/tn-white.jpg");
   progressBar.set('value',100); }

 function clearResults() {
   var resultsTbl = document.getElementById("resultsTable");
   var rowCount = resultsTbl.rows.length;
   for ( var i=0; i<rowCount; i++ ) { resultsTbl.deleteRow(0); }
   var firstRow = document.createElement('tr');
   firstRow.setAttribute('id','firstRow');
   resultsTbl.appendChild(firstRow);
   progressBar.set('value',0);
   document.getElementById("currentEngineDiv").replaceChild(null,document.getElementById("currentEngineDiv").firstChild);}

 function doSearch() {
  YUI().use('json-parse', function (Y) {  
    var rowNumber = 0;  
    //var number = 0;
    var searchQuery = document.getElementById("search_query").value;
    var ajax = new XMLHttpRequest();
    ajax.onreadystatechange = function() {
      if ( ajax.readyState == 4 && ajax.status==200 ) {
        if ( document.getElementById("hiddenValue").value*1.0 == 0 ) {
          var searchHead = document.createElement("th");
          searchHead.setAttribute("style","background-color:#708090;color:#00315D;");
          searchHead.appendChild( document.createTextNode("Search Results") );
          document.getElementById("firstRow").appendChild( searchHead );
        }

        var jsonData = Y.JSON.parse( ajax.responseText );
        for ( var i=0; i<jsonData.table.length; i++ ) {
          var urlCell = document.createElement("a");
          urlCell.href = jsonData.table[i].url;
          urlCell.target = "_blank";
          urlCell.appendChild( document.createTextNode( jsonData.table[i].data ) );
          var dataCell = document.createElement("td");
          dataCell.appendChild( urlCell );
          if ( rowNumber % 2 == 1 ) {
            dataCell.setAttribute("style", "font-weight:bold;background-color:#708090;" );
          } else {
            dataCell.setAttribute("style", "font-weight:bold;" );
          }
          var newRow = document.createElement("tr");
          newRow.appendChild( dataCell );
          document.getElementById("resultsTable").appendChild( newRow );
          rowNumber++;
        }
        incrementHiddenVal();
        var pBarValue = progressBar.get('value') + 12.0;
        progressBar.set('value',pBarValue);
        var req = "ajaxTut.jsp?searchString=" + searchQuery + "&number=" + document.getElementById("hiddenValue").value + "&state=" + stateValue.value;   

        var hiddenVal = document.getElementById("hiddenValue").value*1.0;
        switch( hiddenVal ) {
          case 1: 
            var currentEngineDiv = document.getElementById("currentEngineDiv");
            currentEngineDiv.replaceChild( document.createTextNode("Searching GSA Auctions..."), currentEngineDiv.firstChild );
            break;
          case 2:
            var currentEngineDiv = document.getElementById("currentEngineDiv");
            currentEngineDiv.replaceChild( document.createTextNode("Searching IRS Auctions..."), currentEngineDiv.firstChild );
            break;
          case 3:
            var currentEngineDiv = document.getElementById("currentEngineDiv");
            currentEngineDiv.replaceChild( document.createTextNode("Searching BidCorp..."), currentEngineDiv.firstChild );
            break;
           case 4:
            var currentEngineDiv = document.getElementById("currentEngineDiv");
            currentEngineDiv.replaceChild( document.createTextNode("Searching bid4Assets..."), currentEngineDiv.firstChild );
            break;
           case 5:
            var currentEngineDiv = document.getElementById("currentEngineDiv");
            currentEngineDiv.replaceChild( document.createTextNode("Searching bankruptcysales..."), currentEngineDiv.firstChild );         
            break;
           case 6:
            var currentEngineDiv = document.getElementById("currentEngineDiv");
            currentEngineDiv.replaceChild( document.createTextNode("Searching Public Surplus..."), currentEngineDiv.firstChild );         
            break;
           case 7:
            var currentEngineDiv = document.getElementById("currentEngineDiv");
            currentEngineDiv.replaceChild( document.createTextNode("Searching Government Auction.com..."), currentEngineDiv.firstChild );
            break;
           case 8:
            var currentEngineDiv = document.getElementById("currentEngineDiv");
            currentEngineDiv.replaceChild( document.createTextNode("Searching Homesteps.com..."), currentEngineDiv.firstChild );
            break;
           case 9:
            var currentEngineDiv = document.getElementById("currentEngineDiv");
            currentEngineDiv.replaceChild( document.createTextNode("Searching Homepath.com..."), currentEngineDiv.firstChild );
            break;
           case 10:
            var currentEngineDiv = document.getElementById("currentEngineDiv");
            currentEngineDiv.replaceChild( document.createTextNode("Searching HomeSales.gov..."), currentEngineDiv.firstChild );
           case 11:
            var currentEngineDiv = document.getElementById("currentEngineDiv");
            currentEngineDiv.replaceChild( document.createTextNode("Searching GSA.gov..."), currentEngineDiv.firstChild );
            break;
           case 12:
            var currentEngineDiv = document.getElementById("currentEngineDiv");
            currentEngineDiv.replaceChild( document.createTextNode("Searching GovSales.gov...."), currentEngineDiv.firstChild );
            break;
           case 13:
            var currentEngineDiv = document.getElementById("currentEngineDiv");
            currentEngineDiv.replaceChild( document.createTextNode("Searching LonestarOnline.com...."), currentEngineDiv.firstChild );
            break;
           case 14:
            var currentEngineDiv = document.getElementById("currentEngineDiv");
            currentEngineDiv.replaceChild( document.createTextNode("Searching GovDeals.com...."), currentEngineDiv.firstChild );
            break;
           case 15:
            var currentEngineDiv = document.getElementById("currentEngineDiv");
            currentEngineDiv.replaceChild( document.createTextNode("Searching IllinoisIbid.gov...."), currentEngineDiv.firstChild );
            break;
           case 16:
            var currentEngineDiv = document.getElementById("currentEngineDiv");
            currentEngineDiv.replaceChild( document.createTextNode("Searching PropertyRoom.com...."), currentEngineDiv.firstChild );
            break;
           case 17:
            var currentEngineDiv = document.getElementById("currentEngineDiv");
            currentEngineDiv.replaceChild( document.createTextNode("Searching HUDHomeStore..."), currentEngineDiv.firstChild );
            break;         
        }
        if ( document.getElementById("hiddenValue").value*1.0 < 18.0 ) {
          ajax.open( "GET", req, true );
          ajax.send( null );
        }
        else {
          document.getElementById("currentEngineDiv").replaceChild( document.createTextNode("Search Complete."), document.getElementById("currentEngineDiv").firstChild);
          document.getElementById("spinnerImg").setAttribute("src","http://curezone.com/upload/Members/new03/tn-white.jpg");
        }
      }  
    }

    var stateValue = document.getElementById("state").options.item( document.getElementById("state").selectedIndex );
    var req = "ajaxTut.jsp?number=0&searchString=" + searchQuery + "&state=" + stateValue.value;
    document.getElementById("hiddenValue").value = 0;
    document.getElementById("currentEngineDiv").replaceChild(document.createTextNode("Searching GovLiquidation"),document.getElementById("currentEngineDiv").firstChild);
    document.getElementById("spinnerImg").setAttribute("src", "http://www.andrewdavidson.com/articles/spinning-wait-icons/wait30.gif");
    ajax.open( "GET", req, true );
    ajax.send( null );
   });
  }
</script>
</head>
<body>

<table class="XSP_OUTLINE" align="center" cellpadding="0" cellspacing="0" border="0">
<tr>

<td class="XSP_CENTER_PANEL"><table class="XSP_CENTER_PANEL" cellpadding="0" cellspacing="0" border="0"><tr><td class="XSP_MAIN_PANEL"><div align="center">
    <img style="WIDTH: 793px; HEIGHT: 93px"
         title="Auction Resource"
         border="0"
         alt="Auction Resource"
         src="http://auctionresource.org/images/AuctionResource_mod.jpg"><br>

    <div align="left">
        <table style="POSITION: absolute; BACKGROUND-COLOR: #00315d; WIDTH: 796px; HEIGHT: 22px"
               border="1"
               cellspacing="1"
               cellpadding="0"
               align="left">
            <tbody>
                <tr>
                    <td valign="top"
                        align="left">
                        <p align="center">&nbsp;<strong><a href="http://auctionresource.org/index.html"><font color=
                        "whitesmoke">Home</font></a></strong></p>
                    </td>

                    <td valign="top"
                        align="left">
                        <p align="center">&nbsp;<strong><a href="http://auctionresource.org/Testimonials.php"><font color=
                        "whitesmoke">Testimonials</font></a></strong></p>
                    </td>

                    <td valign="top"
                        align="left">
                        <p align="center"><a href="http://auctionresource.org/F.A.Q.html"><font color=
                        "whitesmoke"><strong>F.A.Q.</strong></font></a></p>
                    </td>

                    <td valign="top"
                        align="left">
                        <p align="center">&nbsp;<strong><a href="http://auctionresource.org/Contact-Us.php"><font color="whitesmoke">Contact
                        Us</font></a></strong></p>
                    </td>

                    <td valign="top"
                        align="left">
                        <p align="center">&nbsp;<font color=
                        "whitesmoke"><strong><u>Bookmark</u></strong></font></p>
                    </td>

                    <td valign="top"
                        align="left">
                        <p align="center">&nbsp; <strong><a href="http://auctionresource.org/Join-Now.php"><font color="whitesmoke">Join
                        Now</font></a></strong></p>
                    </td>
                </tr>
            </tbody>
        </table>
    </div><br>
    &nbsp; 
    <div align="left">
    </div>
</div>

<div align="center" style="font-family:verdana;font-weight:bold;font-size:large;color:#00315D;"><h3 style="color:#00315D;">Government Auction Websites Search Engine</h3>
<input id="search_query" name="search_query" type="text" size="32"><br>
State:<select id="state" name="state">
 <option value='ALL' selected='selected'>ALL</option>
 <option value='AL'>Alabama</option>
 <option value='AK'>Alaska</option>
 <option value='AZ'>Arizona</option>
 <option value='AR'>Arkansas</option>
 <option value='CA'>California</option>
 <option value='CO'>Colorado</option>
 <option value='CT'>Connecticut</option>
 <option value='DE'>Delaware</option>
 <option value='DC'>District of Columbia</option>
 <option value='FL'>Florida</option>
 <option value='GA'>Georgia</option>
 <option value='HI'>Hawaii</option>
 <option value='ID'>Idaho</option> 
 <option value='IL'>Illinois</option>
 <option value='IN'>Indiana</option>
 <option value='IA'>Iowa</option>
 <option value='KS'>Kansas</option>
 <option value='KY'>Kentucky</option>
 <option value='LA'>Lousiana</option>
 <option value='ME'>Maine</option>
 <option value='MD'>Maryland</option>
 <option value='MA'>Massachusetts</option>
 <option value='MI'>Michigan</option>
 <option value='MN'>Minnesota</option>
 <option value='MS'>Mississippi</option>
 <option value='MO'>Missouri</option>
 <option value='MT'>Montana</option>
 <option value='NE'>Nebraska</option>
 <option value='NV'>Nevada</option>
 <option value='NH'>New Hampshire</option>
 <option value='NJ'>New Jersey</option>
 <option value='NM'>New Mexico</option>
 <option value='NY'>New York</option>
 <option value='NC'>North Carolina</option>
 <option value='ND'>North Dakota</option>
 <option value='OH'>Ohio</option>
 <option value='OK'>Oklahoma</option>
 <option value='OR'>Oregon</option>
 <option value='PA'>Pennsylvania</option>
 <option value='PR'>Puerto Rico</option>
 <option value='RI'>Rhode Island</option>
 <option value='SC'>South Carolina</option>
 <option value='SD'>South Dakota</option>
 <option value='TN'>Tennessee</option>
 <option value='TX'>Texas</option>
 <option value='UT'>Utah</option>
 <option value='VT'>Vermont</option>
 <option value='VA'>Virginia</option>
 <option value='WA'>Washington</option>
 <option value='WV'>West Virginia</option>
 <option value='WI'>Wisconsin</option>
 <option value='WY'>Wyoming</option>
</select>
<table><tr><td colspan="2" align="center"><div id="submitButtonContainer" class="yui-skin-sam"></div></td></tr>
<tr><td><div id="stopButtonContainer" class="yui-skin-sam"></div></td><td><div id="newSearchContainer" class="yui-skin-sam"></div></td></tr></table>
<input type="hidden" id="hiddenValue" value="0">
<div align="center">
<div id="currentEngineDiv"><div></div></div>
<img id="spinnerImg" src="http://curezone.com/upload/Members/new03/tn-white.jpg"></img>
<div id="pbContainer" class="yui-skin-sam"></div><br>
<table id="resultsTable" align="center" border="1" cellspacing="1" cellpadding="3" rules="all"><tr id="firstRow"></tr></table>

</td></tr></table></td>
</tr><tr><td colspan="2" class="XSP_FOOTER_PANEL"><p align=center><a href="http://www.auctionresource.org/" style="FONT-SIZE: 8pt; COLOR: WhiteSmoke; FONT-FAMILY: Verdana, Sans-Serif; margin-left:20px; margin-right:20px;">Auction&nbsp;Resource</a><span> </span><a href="http://auctionresource.org/Privacy-Policy-&-Disclaimer.php" style="FONT-SIZE: 8pt; COLOR: WhiteSmoke; FONT-FAMILY: Verdana, Sans-Serif; margin-left:20px; margin-right:20px;">Privacy&nbsp;Policy&nbsp;&&nbsp;Disclaimer</a><span> </span><a href="http://auctionresource.org/Copyright.php" style="FONT-SIZE: 8pt; COLOR: WhiteSmoke; FONT-FAMILY: Verdana, Sans-Serif; margin-left:20px; margin-right:20px;">Copyright</a><span> </span>
</p></td></tr></table>
<script type="text/javascript">
  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-22720406-1']);
  _gaq.push(['_trackPageview']);
  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();</script></body></html>
