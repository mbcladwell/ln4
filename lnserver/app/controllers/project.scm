;; Controller project definition of lnserver
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.
(define-artanis-controller project) ; DO NOT REMOVE THIS LINE!!!
 (use-modules             (artanis utils) (ice-9 local-eval) (srfi srfi-1)
             (artanis irregex)(dbi dbi) (ice-9 textual-ports)(web uri)(ice-9 rdelim)
	     )

(define ciccio (dbi-open "postgresql" "ln_admin:welcome:lndb:socket:192.168.1.11:5432"))


(define (prep-project-rows a)
  (fold (lambda (x prev)
          (let (
                (project_sys_name (result-ref x "project_sys_name"))
                (project_name (result-ref x "project_name"))
		(descr (result-ref x "descr")))
            (cons (string-append "<tr><th><a href=\"localhost:3000/getpsforprj?id=" (number->string (cdr (car x))) "\">" project_sys_name "</a></th><th>" project_name "</th><th>" descr "</th></tr>")
		  prev)))
        '() a))



(project-define getall
  (lambda (rc)
    (let* ((help-topic "project")
	   (ret #f)
	   (holder '())
	   (table-header (string-append "<table><caption><h1>All Projects</h1></caption><tr><th>Project</th><th>Name</th><th>Description</th></tr>"))
	   (dummy (dbi-query ciccio  "select id, project_sys_name, project_name, descr from project"  ))
	   (ret (dbi-get_row ciccio))
	   (dummy2 (while (not (equal? ret #f))     
		     (set! holder (cons ret holder))		   
		     (set! ret  (dbi-get_row ciccio))))
	   (body (string-concatenate (prep-project-rows holder)))
	   )
      (view-render "getall" (the-environment))
  )))

