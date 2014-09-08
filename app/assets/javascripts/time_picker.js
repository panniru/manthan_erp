!!!
%html
  %head
    %meta{:content => "text/html; charset=utf-8", "http-equiv" => "Content-Type"}/
    %link{:href => "css/bootstrap.min.css", :type => "text/css"}/
    %link{:href => "css/bootstrap-timepicker.min.css", :type => "text/css"}/
    %script{:src => "http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js", :type => "text/javascript"}
    %script{:src => "js/bootstrap-2.2.2.min.js", :type => "text/javascript"}
    %script{:src => "js/bootstrap-timepicker.min.js", :type => "text/javascript"}
  %body
    .input-append.bootstrap-timepicker
      %input#timepicker1.input-small{:type => "text"}
        %span.add-on
          %i.icon-time
    :javascript
      $('#timepicker1').timepicker();
