;; Controller utilities definition of lnserver
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.
(define-artanis-controller utilities) ; DO NOT REMOVE THIS LINE!!!

(use-modules (artanis utils)(artanis irregex)(srfi srfi-1)(dbi dbi) (lnserver sys extra))

(define (process-item x) (string-append "<tr><th>"(car x) "</th><th>" (cadr x) "</th></tr>"))


(utilities-define properties
  (lambda (rc)
  "<h1>This is utilities#properties</h1><p>Find me in app/views/utilities/properties.html.tpl</p>"
  ;; TODO: add controller method `properties'
  ;; uncomment this line if you want to render view from template
  ;; (view-render "properties" (the-environment))
  ))



(utilities-define setup
		  (lambda (rc)
		    (let* ((the-file properties-filename)
			   (help-topic "setup")			    
			   (body (string-concatenate (map process-item ln-properties ))))     		  
		    (view-render "setup" (the-environment)))
  ))

(utilities-define login
		  (lambda (rc)
		    (let* ((version ln-version)
			   (connection nopwd-conn)
			   (help-topic "login")	)		    
		    (view-render "login" (the-environment)))
  ))

(utilities-define validate
		  (lambda (rc) 
		    (let* ((user (get-from-qstr rc "name"))
			   (pword (get-from-qstr rc "password"))
			   (help-topic "login")
			   (dummy (dbi-query ciccio (string-append "select id, password from lnuser where lnuser_name ='" user "'" )))
			   (ret (dbi-get_row ciccio)))                      
			   (if (string=? pword (result-ref ret "password"))
			       (let* ((userid (get-c1 ret))	   
				      (dummy (dbi-query ciccio (string-append "SELECT new_session('" userid "')")))
				       (dummy (dbi-query ciccio  "select id from lnsession order by id DESC"))
				     )
				 (view-render "projects/getall" (the-environment)))
			       (view-render "login" (the-environment))))))


(post "/auth" #:auth '(table user "user" "passwd") #:session #t
      (lambda (rc) ...))
