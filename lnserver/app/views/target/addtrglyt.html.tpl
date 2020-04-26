<!-- hitlist#getid view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->

<@include header.tpl %>
  
  <h3>Add Target Layout to PRJ- </h3>


    
  <div>
   <form action="/target/addlayout?name=tname$value&description=descr$value">
  <label for="name">Target Name:</label>  <input type="text" id="tname" name="tname" value=""><br><br>
  <label for="descr">Description:</label>  <input type="text" id="descr" name="descr" value=""><br><br>

    <legend>Please select level of replication:</legend>
<script src="../app/views/target/repbuttons.js"></script>



    <div id="content"></div>

<!--   
  <input type="submit" value="Submit">

-->

  </form>
 </div>

 

<@include footer.tpl %>
