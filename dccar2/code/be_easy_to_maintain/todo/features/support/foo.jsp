<!--
 ! Excerpted from "Build Awesome Command-Line Applications in Ruby 2",
 ! published by The Pragmatic Bookshelf.
 ! Copyrights apply to this code. It may not be used to create training material, 
 ! courses, books, articles, and the like. Contact us if you are in doubt.
 ! We make no guarantees that this code is fit for any purpose. 
 ! Visit http://www.pragmaticprogrammer.com/titles/dccar2 for more book information.
-->
<jsp:useBean id="user" class="com.exmample.models.REALLY.User" />
<h1>Hi!</h1>
<sql:query var="salutation" >
  select salutation from user_salutations where user_id = ?
  <sql:param value="${user.id}" />
</sql:query> 
Hi, ${salutation}!
