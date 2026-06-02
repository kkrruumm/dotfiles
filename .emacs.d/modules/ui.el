;;; ui.el --- -*- lexical-binding: t -*-
;;; Commentary:

;;; Code:
(set-frame-font "JetBrains Mono-10" nil t)

(global-hl-line-mode 1)
(global-display-line-numbers-mode 1)
(global-visual-line-mode t)

(set-face-attribute 'font-lock-comment-face nil :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil :slant 'italic)
(setq-default line-spacing 0.15)

;; pretty bar
(unless (package-installed-p 'doom-modeline)
  (package-install 'doom-modeline))
(doom-modeline-mode 1)
(setq doom-modeline-total-line-number 1)
(setq doom-modeline-major-mode-color-icon nil)

;; probably the most normal thing about this
(unless (package-installed-p 'dashboard)
  (package-install 'dashboard))
(require 'dashboard)
(setq dashboard-banner-logo-title nil)
(setq dashboard-center-content t)
(setq dashboard-vertically-center-content t)
(setq dashboard-items '((recents   . 10)
                        (projects  . 10)
                        (bookmarks . 5)))
(setq dashboard-projects-backend 'project-el)

;; dashboard + emacsclient
(setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
(dashboard-setup-startup-hook)

(add-hook 'server-after-make-frame-hook
          (lambda ()
            (when (get-buffer "*dashboard*")
              (with-current-buffer "*dashboard*"
                (dashboard-refresh-buffer)))))

;; set terminal title
(defun update-terminal-title ()
  "Set the terminal title to the current file name."
  (when (and (buffer-file-name)
             (eq (current-buffer) (window-buffer (selected-window))))
    (send-string-to-terminal
     (format "\e]2;emacs - %s\a" (buffer-file-name)))))

(add-hook 'window-selection-change-functions (lambda (_frame) (update-terminal-title)))
(add-hook 'find-file-hook                    #'update-terminal-title)
(add-hook 'buffer-list-update-hook           #'update-terminal-title)
(add-hook 'window-configuration-change-hook  #'update-terminal-title)

;; removes the border between emacs and the terminal by syncing bg color
(defun set-terminal-bg (color &optional frame)
  "Set terminal background to COLOR for FRAME."
  (let ((frame (or frame (selected-frame))))
    (unless (display-graphic-p frame)
      (send-string-to-terminal
       (format "\033]11;%s\033\\" color)
       frame))))

(defun reset-terminal-bg (&optional frame)
  "Restore the terminal's original background for FRAME."
  (let ((frame (or frame (selected-frame))))
    (unless (display-graphic-p frame)
      (send-string-to-terminal "\033]111\033\\" frame))))

;; xterm-256color on foot produces slightly different colors, hence the hardcoded value
(add-hook 'server-after-make-frame-hook (lambda () (set-terminal-bg "#060606")))
(add-hook 'server-done-hook             (lambda () (reset-terminal-bg)))

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'bummer t)

(provide 'ui)
;;; ui.el ends here
