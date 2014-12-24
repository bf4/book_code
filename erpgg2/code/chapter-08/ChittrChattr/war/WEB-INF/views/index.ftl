<#include "_top.ftl">

<div class="page-header">
  <h1>Welcome to ChittrChattr</h1>
</div>

<p class="lead"
<ul>
  <#list pg.list as blog>
  <li><a href="/posts/${ blog.nickname }">${ blog.title }</a></li>
  </#list>
</ul>
<#if pg.more>
<a href="?page=${ pg.current + 1 }">More Blogs...</a>
</#if>

<#include "_bottom.ftl">
