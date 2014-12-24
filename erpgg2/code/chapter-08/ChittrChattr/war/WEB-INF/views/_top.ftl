<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/2.3.2/css/bootstrap.min.css">
    <style>
	  html,body { height: 100%; }
      #wrap {
        min-height: 100%;
        height: auto !important;
        height: 100%;
        margin: 0 auto -60px;
      }
      @media (max-width: 979px) {
        #wrap { margin: -66px auto; }
      }
      #push, #footer { height: 60px; }
      #footer { background-color: #f5f5f5; }
      @media (max-width: 767px) {
        #footer {
          margin-left: -20px;
          margin-right: -20px;
          padding-left: 20px;
          padding-right: 20px;
        }
      }
      #wrap > .container { padding-top: 60px; }
      .container p { margin: 20px 0; }
      #newpost {
      	background-color:#dceaf4;
      	padding:1em;
      }
      #posts {
        margin-bottom:1em;
      }
      #posts h3 {
        line-height: 32px;
      }
      #posts h3 small {
        white-space:nowrap;
      }
    </style>
    <script src="//code.jquery.com/jquery.js"></script>
    <script src="//netdna.bootstrapcdn.com/bootstrap/2.3.2/js/bootstrap.min.js"></script>
    <title>ChittrChattr</title>
  </head>
  <body>

  <div class="navbar navbar-inverse navbar-fixed-top">
    <div class="navbar-inner">
      <div class="container">
        <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>
        <a class="brand" href="/">ChittrChattr</a>
        <div class="nav-collapse collapse">
          <ul class="nav">
            <li><a href="/">Home</a></li>
            <#if (user.blog)??>
            <li><a href="/posts/${ user.blog.nickname }">My Posts</a></li>
            <#else>
            <li><a href="/blog">Create a Blog</a></li>
            </#if>
            <#if user??>
            <li><a href="/followed">My Follows</a></li>
            <li><a href="/logout">Logout</a></li>
            <#else>
            <li><a href="/oauth2callback">Login</a></li>
            </#if>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </div>
  </div>

<div id="wrap">
  <div class="container">