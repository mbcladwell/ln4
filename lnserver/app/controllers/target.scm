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


(define (prep-trglytname-rows a)
  (fold (lambda (x prev)
          (let ((id (get-c1 x))
		(prj-id  (get-c2 x ))
		(trg-lyt-sys-name (result-ref x "target_layout_name_sys_name"))
		(trg-name (result-ref x "target_layout_name_name"))
		(descr (result-ref x "target_layout_name_desc"))
		(reps (get-c6 x)))	      
	    (cons (string-append "<tr><th>"
				 (if (string? prj-id)
				     (string-append "PRJ-" prj-id)
				     '(""))
				 "</th><th><a href=\"gettrglytbyid?id=" id "\">" trg-lyt-sys-name  "</a></th><th>" trg-name "</th><th>" descr "</th><th>" reps "</th></tr>")
		  prev)))
        '() a))


(target-define gettrglyt
		(lambda (rc)
		  (let* ((ret #f)
			 (holder '())
			 (help-topic "target")
			 (dummy (dbi-query ciccio (string-append "select id, project_id, target_layout_name_sys_name, target_layout_name_name, target_layout_name_desc, reps from target_layout_name" )))
			 (ret (dbi-get_row ciccio))
			 (dummy2 (while (not (equal? ret #f))     
				   (set! holder (cons ret holder))		   
				   (set! ret  (dbi-get_row ciccio))))
			 (body  (string-concatenate  (prep-trglytname-rows holder)) ))
		    (view-render "gettrglyt" (the-environment)))))



(define (prep-trglytbyid-rows a)
  (fold (lambda (x prev)
          (let ((id (get-c1 x))
		(prj-id  (get-c4 x ))
		(trg-sys-name (result-ref x "target_sys_name"))
		(trg-name (result-ref x "target_name"))
		(trg-descr (result-ref x "descr"))		
		(quad (get-c6 x)))
	    (cons (string-append "<tr><th><a href=\"gettrgbyid?id=" id "\">" trg-sys-name  "</a></th><th>"
				 (if (string? prj-id)
				     (string-append "PRJ-" prj-id)
				     '(""))
				 "</th><th>" trg-name "</th><th>" quad "</th><th>" trg-desc "</th></tr>")
		  prev)))
        '() a))



(target-define gettrglytbyid
		(lambda (rc)
		  (let* ((ret #f)
			 (holder '())
			 (help-topic "target")
			 (id  (get-from-qstr rc "id"))
			 (dummy (dbi-query ciccio (string-append "select target.id, target.target_sys_name, target.descr, target_layout_name.project_id, target.target_name, target_layout.quad, target_layout_name_sys_name, target_layout_name_name, target_layout_name_desc, target_layout_name.reps from target_layout_name, target_layout, target WHERE target_layout.target_layout_name_id=target_layout_name.id AND target_layout.target_id=target.id AND target_layout_name.id=" id)))
			 (ret (dbi-get_row ciccio))
			 (trg-lyt-sys-name (result-ref ret "target_layout_name_sys_name"))
			 (trg-lyt-name (result-ref ret "target_layout_name_name"))
			 (trg-lyt-descr (result-ref ret "target_layout_name_desc"))
			 (reps (get-c10 ret))
			 (header (string-append "Targets in " trg-lyt-sys-name "\nName: " trg-lyt-name "\nDescription: " trg-lyt-descr "\nReplication: " reps))
			 
			 (dummy2 (while (not (equal? ret #f))     
				   (set! holder (cons ret holder))		   
				   (set! ret  (dbi-get_row ciccio))))
			 (body  (string-concatenate  (prep-trglytbyid-rows holder)) ))
		    (view-render "gettrglytbyid" (the-environment)))))
