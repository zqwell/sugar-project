#|
  This file is a part of sugar-project project.
  Copyright (c) 2013 zqwell (zqwell.ss@gmail.com)
|#

#|
  Generate project skeletons

  Author: zqwell (zqwell.ss@gmail.com)
|#

(in-package :cl-user)
(defpackage sugar-project-asd
  (:use :cl :asdf))
(in-package :sugar-project-asd)

(defsystem sugar-project
  :version "0.1"
  :author "zqwell"
  :license "LLGPL"
  :depends-on (:cl-project
               :cl-annot
               :cl-fad)
  :components ((:module "src"
                :components
                ((:file "sugar-project"))))
  :description "Generate project skeletons"
  :long-description
  #.(with-open-file (stream (merge-pathnames
                             #p"README.markdown"
                             (or *load-pathname* *compile-file-pathname*))
                            :if-does-not-exist nil
                            :direction :input)
      (when stream
        (let ((seq (make-array (file-length stream)
                               :element-type 'character
                               :fill-pointer t)))
          (setf (fill-pointer seq) (read-sequence seq stream))
          seq)))
  :in-order-to ((test-op (load-op sugar-project-test))))
