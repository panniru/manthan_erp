class RequestBooksMailer < ActionMailer::Base
  default from: "from@example.com"   

  def request_book_mail(mail_subject,mail_message,request_books,my_vendor)
  	@mail_message = mail_message  
    @request_books = request_books
    @my_vendor = my_vendor 
    emails = my_vendor["vendor_email"] 	
  	mail(to: emails, subject: mail_subject)    
  end
end
