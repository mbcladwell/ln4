<!-- hitlist#getid view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->

<@include header.tpl %>
  <h3>Add Target Layout to PRJ- </h3>

  <div>
   <form action="/target/addlayout?name=tname$value&description=descr$value&accs=accs$value">
  <label for="name">Target Name:</label>  <input type="text" id="tname" name="tname" value=""><br><br>
  <label for="descr">Description:</label>  <input type="text" id="descr" name="descr" value=""><br><br>

<fieldset>
    <legend>Please select level of replication:</legend>
    <div>
       <input type="radio" id="singlicates" name="replication" value="1" checked><label for="singlicates">Singlicates</label>
 <input type="radio" id="duplicates" name="replication" value="2">  <label for="duplicates">Duplicates</label> 
 <input type="radio" id="quadruplicates" name="replication" value="4"
         ><label for="quadruplicates">Quadruplicates</label> 
  </div>
</fieldset>



  
  <input type="submit" value="Submit">
  </form>
 </div>

  
<hr>
<h3>Add Target to PRJ- </h3><br>

<div>
   <form action="/target/addsingle?name=tname$value&description=descr$value&accs=accs$value">
  <label for="name">Target Name:</label>  <input type="text" id="tname" name="tname" value=""><br><br>
  <label for="descr">Description:</label>  <input type="text" id="descr" name="descr" value=""><br><br>
  <label for="accs">Accession ID:</label>  <input type="text" id="accs" name="accs" value=""><br><br>
  <input type="submit" value="Submit">
  </form>
 </div>


<hr>
  <h3>Bulk Target Upload</h3>

<div>
<form action="/addbulk">
 <label for="avatar">Choose bulk target upload file:</label>

<input type="file"
       id="avatar" name="avatar"
       accept=".txt, .csv">
</form>
</div>
<br>
 <div>
   <button>Submit</button>
 </div>



<@include footer.tpl %>
