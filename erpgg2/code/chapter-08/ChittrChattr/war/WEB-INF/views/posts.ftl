<#include "_top.ftl">
    <form action="/followed/${blog.nickname}" method="POST" id=fav></form>

<div class="page-header">
  <h1>
    ${ blog.title }
    <#if user??><#if notFollowed>
    <button form=fav type=submit class="btn btn-mini"><i class="icon-heart"></i> Follow</button>
    </#if></#if>
  </h1>

  <#if ownsBlog>
  <!-- If this user owns this blog, let them make a post -->
  <section id="newpost">
  <h4>Make a New Post</h4>
  <form action="/posts" method="POST" class="form-horizontal">
    <input type="hidden" name="nickname" value="${ blog.nickname }">
    <div class="control-group">
      <label class="control-label" for="title"><i class="icon-tag"></i> Title</label>
      <div class="controls">
        <input name="title" placeholder="Post Title">
      </div>
    </div>
    <div class="control-group">
      <label class="control-label" for="body"><i class="icon-comment"></i> Body</label>
      <div class="controls">
        <textarea name="body" placeholder="What I want to say" rows="3" cols="50"></textarea>
      </div>
    </div>
    <div class="control-group">
      <div class="controls">
        <input type="submit" value="Add Post">
      </div>
    </div>
  </form>
  </section>
</#if>

</div>


<section id="posts">
  <#if (pg.list[0])??>
  <#list pg.list as post>
    <section class="post" id="${ post.blogKey }">
      <h3>${ post.title }</h3>
      <time>${ post.timestamp?datetime }</time>
      <div class="body">${ post.body }</div>
    </section>
  </#list>
  <#if pg.more>
  <a href="?page=${ pg.current + 1 }">More Posts...</a>
  </#if>
  <#else>
  <p class="muted">No posts yet</p>
  </#if>
</section>

<#include "_bottom.ftl">