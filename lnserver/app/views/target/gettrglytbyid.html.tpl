<!-- hitlist#getid view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->

<@include header.tpl %>
  <h3>
  Targets for Target Layout <%= trg-lyt-sys-name %><br><br>
  Name: <%= trg-lyt-name %><br><br>
  Description: <%= trg-lyt-descr %><br><br>
  Replication: <%= reps %><br><br>
  </h3>
<table><tr><th>ID</th><th>Project</th><th>Name</th><th>Quadrant</th></tr>
  <%= body %>
</table>


<@include footer.tpl %>
