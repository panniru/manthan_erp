class RequestBooksMailer < ActionMailer::Base
  default from: "from@example.com"   

  def request_book_mail(mail_subject,mail_message,request_books,emails)
  	@mail_message = mail_message  
    @request_books = request_books  	
  	mail(to: emails.join(","), subject: mail_subject)    
  end
end
