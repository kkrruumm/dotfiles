;;; config-core.el --- -*- lexical-binding: t -*-
;;; Commentary:

;;; Code:
(require 'package)
(setq package-archives nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("elpa"  . "https://elpa.gnu.org/packages/"))
(package-initialize)

;; uncomment when adding new packages or on a fresh install
;; (package-refresh-contents)

;; custom file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; file behavior
(setq auto-save-default nil)
(setq create-lockfiles nil)
(setq delete-auto-save-files t)
(setq find-file-visit-truename t)
(setq large-file-warning-threshold nil)
(setq make-backup-files nil)

;; emacsclient buffers should persist
(setq server-kill-new-buffers nil)

;; recentf
(recentf-mode 1)
(setq recentf-max-saved-items 50)

;; ibuffer settings
(setq ibuffer-auto-mode t)
(add-hook 'ibuffer-mode-hook #'ibuffer-auto-mode)

;; scrolling settings
(setq scroll-margin 6
      scroll-conservatively 101)
(setq next-line-add-newlines nil)

;; y/n prompts instead of yes/no
(setq read-answer-short t)
(if (boundp 'use-short-answers)
    (setq use-short-answers t)
  (advice-add 'yes-or-no-p :override #'y-or-n-p))

;; save cursor position in files
(save-place-mode 1)

(setq which-func-update-delay 1.0)

(defun register-projects-directory (parent-dir)
  "Register every subdirectory of PARENT-DIR as a project."
  (let ((parent (expand-file-name parent-dir)))
    (when (file-directory-p parent)
      (dolist (dir (directory-files parent t "^[^.]"))
        (when (file-directory-p dir)
          (project-remember-project (cons 'transient dir)))))))

(with-eval-after-load 'project
  (register-projects-directory "~/Documents/projects"))

(provide 'config-core)
;;; config-core.el ends here
