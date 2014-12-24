<#include "_top.ftl">

<div class="page-header">
  <h1>My Followed Posts <i class="icon-heart"></i></h1>
</div>

<section id="posts">
  <#list pg.list as post>
    <section class="post" id="${ post.blogKey }">
      <h3>${ post.title } <small>${ post.timestamp?datetime }</small></h3>
      
      <div class=body>${ post.body }</div>
    </section>
  </#list>
  <#if pg.more>
  <a href="?page=${ pg.current + 1 }">More Posts...</a>
  </#if>
</section>

<#include "_bottom.ftl">