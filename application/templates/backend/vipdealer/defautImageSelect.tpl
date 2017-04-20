<div id="stack1" class="modal hide fade" data-focus-on="input:first" style="width:800px;">

  <div class="modal-header">

    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>

    <h3>选择文件</h3>

  </div>

  <div class="modal-body">
    <table class="table table-striped table-bordered table-hover dataTable" aria-describedby="sample_1_info" cellspacing="0">
        <thead>
          <tr>
            <th>文件名称</th>
            <th width="20%">文件类型</th>
            <th width="20%">文件大小</th>
            <th width="20%">修改日期</th>
          </tr>
        </thead>
        <tbody>
          <{foreach from=$defaultImageList item=f_item}>
          <tr align="center" data-img-path="<{$f_item.relative_path|cat:$f_item.name}>">
            <td>
                <img src="<{base_url url=$f_item.relative_path|cat:$f_item.name}>"  width="200" height="100"/>
                <{$f_item.name}>
            </td>
            <td><{$f_item.mime}></td>
            <td><{byte_format($f_item.size)}></td>
            <td><{$f_item.date|date_format:'%Y-%m-%d'}></td>
          </tr>
          <{/foreach}>
        </tbody>
    </table>
  </div>

  <div class="modal-footer">

    <button type="button" data-dismiss="modal" class="btn">Close</button>

  </div>            

</div>

<script type="text/javascript">
  $(function(){
    $('#stack1 table tr').click(function(){
      var image = $(this).data('img-path');
      $('.thumbnail img').attr('src' ,'/'+image);
      $('#selectImg').val(image);

      $('.modal-footer button').click();
    });
  });
</script>