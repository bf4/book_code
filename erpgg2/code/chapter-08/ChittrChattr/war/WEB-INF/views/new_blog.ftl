<#include "_top.ftl">

<div class="page-header">
  <h1>Create a new Blog</h1>
</div>

<form action="/blog" method="POST" class="form-horizontal">
  <div class="control-group">
    <label class="control-label" for="title">Blog Title</label>
    <div class="controls">
      <input name="title" placeholder="Blog Title">
    </div>
  </div>
  <div class="control-group">
    <label class="control-label" for="nickname">Nickname</label>
    <div class="controls">
      <input name="nickname" placeholder="nickname">
    </div>
  </div>
  <div class="control-group">
    <div class="controls">
      <div class="text-error">${ error }</div>
      <input type="submit" value="Create Account">
    </div>
  </div>
</form>

<#include "_bottom.ftl">