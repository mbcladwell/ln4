;; Controller plateset definition of lnserver
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.
(define-artanis-controller plateset) ; DO NOT REMOVE THIS LINE!!!

(use-modules (artanis utils)(artanis irregex)(srfi srfi-1)(dbi dbi) (lnserver sys extra))

(define (prep-ps-rows a)
  (fold (lambda (x prev)
          (let (
                (plate_set_sys_name (result-ref x "plate_set_sys_name"))
                (plate_set_name (result-ref x "plate_set_name"))
		(descr (result-ref x "descr")))
            (cons (string-append "<tr><th><a href=\"/plate/getpltforps?id=" (number->string (cdr (car x))) "\">" plate_set_sys_name "</a></th><th>" plate_set_name "</th><th>" descr "</th></tr>")
		  prev)))
        '() a))



(define (get-assay-runs-for-prjid id)
  (let* ((ret #f)
	(holder '())
	(dummy (dbi-query ciccio (string-append "select assay_run.id, assay_run.assay_run_sys_name, assay_run.assay_run_name, assay_run.descr, assay_type.assay_type_name, plate_layout_name.sys_name, plate_layout_name.name FROM assay_run, assay_type, plate_set, plate_layout_name WHERE assay_run.plate_layout_name_id=plate_layout_name.id AND assay_run.assay_type_id=assay_type.id AND assay_run.plate_set_id=plate_set.id AND plate_set.project_id =" id )))
	(ret (dbi-get_row ciccio))
	(dummy2 (while (not (equal? ret #f))     
		  (set! holder (cons ret holder))		   
		  (set! ret  (dbi-get_row ciccio)))))
	 (string-concatenate (prep-ar-rows holder))))


(define (prep-hl-rows a)
  (fold (lambda (x prev)
          (let (
                (assay-run-sys-name (result-ref x "assay_run_sys_name"))
		(hit-list-sys-name (result-ref x "hit_list_sys_name"))
		(hit-list-name (result-ref x "hit_list_name"))
		(descr (result-ref x "assay_type_name"))
		(sys-name (result-ref x "sys_name"))
		(name (result-ref x "name"))
		)
            (cons (string-append "<tr><th><a href=\"/assayrun/gethlforarid?id=" (number->string (cdr (car x))) "\">" assay-run-sys-name "</a></th><th>" assay-run-name "</th><th>" descr "</th><th>" assay-type-name "</th><th>" sys-name "</th><th>" name "</th><tr>")
		  prev)))
        '() a))



(define (get-hit-lists-for-prjid id)
  (let* ((ret #f)
	(holder '())
	(dummy (dbi-query ciccio (string-append "select assay_run.assay_run_sys_name, hit_list.hitlist_sys_name, hit_list.hitlist_name, hit_list.descr, hit_list.n  FROM assay_run, plate_set, hit_list WHERE hit_list.assay_run_id=assay_run.id  AND assay_run.plate_set_id=plate_set.id AND plate_set.project_id =" id )))
	(ret (dbi-get_row ciccio))
	(dummy2 (while (not (equal? ret #f))     
		  (set! holder (cons ret holder))		   
		  (set! ret  (dbi-get_row ciccio)))))
	 (string-concatenate (prep-hl-rows holder))))




(plateset-define getps
		 (lambda (rc)
		   (let* ((ret #f)
			  (holder '())
			  (help-topic "plateset")
			  (id  (get-from-qstr rc "id"))
			  (dummy (dbi-query ciccio (string-append "select id, plate_set_sys_name, plate_set_name, descr from plate_set where project_id =" id )))
			  (ret (dbi-get_row ciccio))
			  (dummy2 (while (not (equal? ret #f))     
				    (set! holder (cons ret holder))		   
				    (set! ret  (dbi-get_row ciccio))))
			  (body  (string-concatenate  (prep-ps-rows holder)) )
			  (assay-runs (get-assay-runs-for-prjid id)))      
		     (view-render "getps" (the-environment))
		     )))

