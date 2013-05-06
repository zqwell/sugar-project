#|
  This file is a part of sugar-project project.
  Copyright (c) 2013 zqwell (zqwell.ss@gmail.com)
|#

(in-package :cl-user)
(defpackage sugar-project-test-asd
  (:use :cl :asdf))
(in-package :sugar-project-test-asd)

(defsystem sugar-project-test
  :author "zqwell"
  :license "LLGPL"
  :depends-on (:sugar-project
               :cl-test-more)
  :components ((:module "t"
                :components
                ((:file "sugar-project"))))
  :perform (load-op :after (op c) (asdf:clear-system c)))
