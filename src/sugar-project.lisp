#|
  This file is a part of sugar-project project.
  Copyright (c) 2013 zqwell (zqwell.ss@gmail.com)
|#

(in-package :cl-user)
(defpackage sugar-project
  (:use :cl))
   
(in-package :sugar-project)

(cl-annot:enable-annot-syntax)

@export
(defvar *author* nil
  "Your Name")

@export
(defvar *email* nil
  "your.name@example.com")

@export
(defvar *license* nil
  "Specify license here")

@export
(defvar *skeleton-list*
  `((:name :capi-standard
     :description "CAPI standard skeleton."
     :directory "~/cl-skeleton/capi/")
    (:name :cl-project-default
     :description "cl-project default skeleton."
     :directory ,cl-project:*skeleton-directory*)
    )
  "プロジェクトのテンプレートを指定する")

@export
(defvar *default-skeleton*
  :cl-project-default
  "set :name as default skeleton.")

(defun find-skeleton (name)
  (find name *skeleton-list*
        :key (lambda (item)
               (getf item :name))))


(defun print-skeleton-list (skeletons)
  (princ
   (with-output-to-string (str)
     (mapc (lambda (skeleton)
             (format str "* ~(~A~)~:[~; (default)~]~%"
                     (getf skeleton :name)
                     (eql *default-skeleton* (getf skeleton :name)))
             (format str "[~@(~11A~)] ~(~S~)~%" :name (getf skeleton :name))
             (format str "[~@(~11A~)] ~(~A~)~%" :description (getf skeleton :description))
             (format str "[~@(~11A~)] ~(~A~)~%" :directory (getf skeleton :directory))
             (format str "~%" :directory (getf skeleton :directory)))
           skeletons)))
  nil)

@export
(defun config (&rest params &key set-default)
  (cond
   ((null params)
    (print-skeleton-list *skeleton-list*))
   (set-default
    (when (find-skeleton set-default)
      (setf *default-skeleton* set-default)))))

@export
(defun make-project (path &rest params &key
                          (skeleton *default-skeleton*)
                          name
                          description
                          (author *author*)
                          (email *email*)
                          (license *license*)
                          depends-on
                          &allow-other-keys)
  (declare (ignorable name description author email license depends-on))
  (setf (getf params :author) author
        (getf params :email) email
        (getf params :license) license)
  (let ((cl-project:*skeleton-directory*
         (cl-fad:pathname-as-directory
          (getf (find-skeleton skeleton) :directory))))
    (apply #'cl-project:make-project path params)))
