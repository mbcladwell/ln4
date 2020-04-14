;; Controller target definition of lnserver
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.
(define-artanis-controller target) ; DO NOT REMOVE THIS LINE!!!

(use-modules (artanis utils)(artanis irregex)(srfi srfi-1)(dbi dbi) (lnserver sys extra))


(define (prep-trg-rows a)
  (fold (lambda (x prev)
          (let ((id (get-c1 x))
		(target-sys-name (result-ref x "target_sys_name"))
		(prj-id (get-c3 x ))
		(trg-name (result-ref x "target_name"))
		(descr (result-ref x "descr"))
		(accs (result-ref x "accs_id")))	      
	      (cons (string-append "<tr><th>"  target-sys-name "</th><th>" prj-id "</th><th>" trg-name "</th><th>" descr "</th><th>" accs "</th><tr>")
		  prev)))
        '() a))


(target-define getall
		(lambda (rc)
		  (let* ((ret #f)
			 (holder '())
			 (help-topic "target")
			 (dummy (dbi-query ciccio (string-append "select id, target_sys_name, project_id, target_name, descr, accs_id from target" )))
			 (ret (dbi-get_row ciccio))
			 (dummy2 (while (not (equal? ret #f))     
				   (set! holder (cons ret holder))		   
				   (set! ret  (dbi-get_row ciccio))))
			 (body  (string-concatenate  (prep-trg-rows holder)) ))
		    (view-render "getall" (the-environment)))))


