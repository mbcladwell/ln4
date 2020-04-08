<!-- plate#getid view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->

<@include header.tpl %>
<table><caption><h1>Plates for PS-<%= id %></h1></caption><tr><th>Plate</th><th>Barcode</th></tr>
  <%= body %>
</table>

<table><caption><h1>Assay Runs for PS-<%= id %></h1></caption><tr><th>Assay Run</th><th>Name</th><th>Description</th><th>Type</th><th>Layout</th><th>Layout Name</th></tr>
 <%= body2 %>

  </table>
<@include footer.tpl %>
