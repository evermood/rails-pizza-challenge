url = '<%= order_path  @order %>'
line = $("a[href='#{url}']").closest('tr')
line.fadeOut 1000, ->
  line.remove()
