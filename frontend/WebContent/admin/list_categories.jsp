<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.upv.satrd.fic2.fe.config.*,org.upv.satrd.fic2.fe.main.*,java.sql.*, org.upv.satrd.fic2.fe.db.*,java.util.ArrayList, java.text.*,java.util.HashMap" %>
<%@ page import="org.apache.log4j.Logger" %>
<% Logger log = Logger.getLogger("JSP.list_categories");%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link rel='stylesheet' type='text/css' href="../css/main.css">
  <link rel='stylesheet' type='text/css' href="../css/table.css"> 
  <script type='text/javascript' language='javascript'>

    function editar(id){
      if (id == 0){
        location.href='new_category.jsp';
      }else{
        location.href='edit_category.jsp?id_selected='+id;
      }
    }

    function borrar(id,name){
      if (confirm('Do you want to delete "'+name+'" permanently?')){
    	  location.href='delete_category.jsp?id_selected='+id;
	  }
    }

  </script>

</head>
<body bgcolor="white" style="{ margin:0;}" background="../img/centerf2.png" style="{ background-repeat: no-repeat;}">

   
  <%    
	String relativeWebPath = "/config/config.xml";
	String configPath = getServletContext().getRealPath(relativeWebPath);
	Configuration configFile = new Configuration(configPath);
	Connection con = OutputDB.connectDB(
			configFile.getConnectionString(),
			configFile.getUser(),
			configFile.getPwd(),
			configFile.getDriverName(),null);
    
    String state = "";
    
    
    //Get data
    ArrayList<Category> categories = Category.getCategoryList(con,null);
    int num = categories.size();    
  
  %>

  <center>
  <div class='main_content'> 
    <font class='titulo'>Categories</font>
    
    
    <table class='' style='margin: 20px 0 10px 0;' cellspacing='0' border='1'>
      <thead style='display:block;'>
        <tr>
          <th width='200'>Name</th>
          <th width='300'>Description</th>
          <th width='63'>&nbsp;</th>
        </tr>
      </thead>
      <tbody  style='display:block; <% if (num >14) { %> height:500px; overflow-y:scroll;<% } %>'>


<% 
    for(int j = 0; j < num; j = j+1) {
    	Category category = categories.get(j);
%>
     
        <% if (j%2 !=0 ){ %>
        	<tr class="odd">
        <% }else{ %>
        	<tr> 
        <%} %>                          
          <td width='200'><%=category.getName().toString()%></td>
          <%
             String description;
             if (category.getDescription() == null) description=""; else description=category.getDescription();
          %>
          <td width='300'><%=description%></td>
          <td width='<% if (num >14) {%>50<%}else{%>63<%}%>>' align='center'>
            <img class='img' src='../img/edit.png' OnClick="editar(<%=category.getId().toString()%>)" width='20px' title='View/Edit source' />
            <img class='img' src='../img/delete.png' OnClick="borrar('<%=category.getId().toString()%>','<%=category.getName()%>')" width='20px' title='Delete category' />
          </td>
        </tr>

<%
   }
%> 
      </tbody>
      <tfoot>
        <tr><td colspan='6' align='right'><img class='img' src='../img/new.png' OnClick='editar(0)' width='20px' title='New category' />&nbsp;&nbsp;&nbsp;</td></tr>
      </tfoot>
    </table>
    <br>
    <input type="button"  value="Return" OnClick="location.href='configuration.jsp'" class="boton" style="width: 160px;">

  </div> 
  </center>

 

 <%  OutputDB.disconnectDB(con,null); %>
  

</body>
</html>