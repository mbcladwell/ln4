;; Controller project definition of ln4
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.
(define-artanis-controller project) ; DO NOT REMOVE THIS LINE!!!

(project-define get
  (lambda (rc)
    "<h1>This is project#get</h1><p>Find me in app/views/project/get.html.tpl</p>"
    (let((help-topic "this is a help-topic"))
  ;; TODO: add controller method `get'
  ;; uncomment this line if you want to render view from template
   (view-render "get" (the-environment)))
  ))
