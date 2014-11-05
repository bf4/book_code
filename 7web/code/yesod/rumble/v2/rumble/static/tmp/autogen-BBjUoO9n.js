/***
 * Excerpted from "Seven Web Frameworks in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/7web for more book information.
***/
function h2(){if(navigator.id){navigator.id.watch({onlogin:function(assertion){if(assertion)document.location="http://localhost:3000/auth/page/browserid/"+assertion},onlogout:function(){}});navigator.id.request({returnTo:"/auth/login"+"?autologin=true"})}else alert("Loading, please try again")};(function(){var bid=document.createElement("script");bid.async=true;bid.src="https://login.persona.org/include.js";var s=document.getElementsByTagName('script')[0];s.parentNode.insertBefore(bid,s)})()