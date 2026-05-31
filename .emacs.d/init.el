;;; init.el --- -*- lexical-binding: t -*-

;;; Commentary:
;;

;;; Code:
(require 'package)
(add-to-list 'package-archives
    '("melpa" . "https://melpa.org/packages/")
    '("elpa" . "https://elpa.gnu.org/packages/"))
(package-initialize)

;; max gc threshhold for startup
(setq gc-cons-threshold most-positive-fixnum)
(setq gc-cons-percentage 1.0)

;; uncomment when adding packages or if this is a new emacs installation
(package-refresh-contents)

;; let there be highlight (this is only really here for lua)
(unless (package-installed-p 'treesit-auto)
  (package-install 'treesit-auto))

;; ricer slop (easier to read)
(set-frame-font "JetBrains Mono-10" nil t)

;; disabling treesit-auto so it doesn't try to pull in anything else post-lua
(add-to-list 'major-mode-remap-alist '(lua-mode . lua-ts-mode)) ;; this explicitly enables treesitter for lua, without treesitter lua is not well highlighted

;; this should be temporarily reenabled if this is a new emacs installation
;;(use-package treesit-auto
;;  :custom
;;  (treesit-auto-install 'prompt)
;;  :config
;;  (treesit-auto-add-to-auto-mode-alist 'all)
;;  (global-treesit-auto-mode))

;; less conservative highlighting level
(setq treesit-font-lock-level 4)

;; spell checking
(add-hook 'text-mode-hook 'flyspell-mode) ;; spellcheck for org, markdown, all that
(add-hook 'find-file-hook (lambda () (when (eq major-mode 'fundamental-mode) (flyspell-mode 1)))) ;; fundamental mode, so applies to mdx and various other non coding things
;; (add-hook 'prog-mode-hook 'flyspell-prog-mode) ;; this spellchecks only comments and strings if checking code

;; markdown-replacer-9000 (buy now!)
(use-package org
  :ensure nil
  :hook
  (org-mode . org-indent-mode)
  (org-mode . visual-line-mode)
  :config
  (setq org-startup-folded 'content ;; start folded
        org-src-fontify-natively t ;; syntax highlighting for code blocks
        org-src-tab-acts-natively t))

;; dashboard
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

;; dashboard needs this to work with emacsclient
(setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
(dashboard-setup-startup-hook)

;; refresh the dashboard buffer every time a client connects to make sure the vertical centering works
(add-hook 'server-after-make-frame-hook
          (lambda ()
            (when (get-buffer "*dashboard*")
              (with-current-buffer "*dashboard*"
                (dashboard-refresh-buffer)))))

;; auto-register every subdirectory of my projects dir as a project
(defun register-projects-directory (parent-dir)
  (let ((parent (expand-file-name parent-dir)))
    (when (file-directory-p parent)
      (dolist (dir (directory-files parent t "^[^.]"))
        (when (file-directory-p dir)
          (project-remember-project (cons 'transient dir)))))))

;; update the terminal title with filename so i don't lose track of stuff in my sway tabs
(defun update-terminal-title ()
  (when (and (buffer-file-name)
             (eq (current-buffer) (window-buffer (selected-window))))
    (send-string-to-terminal
     (format "\e]2;emacs - %s\a" (buffer-file-name)))))

(add-hook 'window-selection-change-functions
          (lambda (_frame) (update-terminal-title)))
(add-hook 'find-file-hook #'update-terminal-title)

(add-hook 'buffer-list-update-hook #'update-terminal-title)
(add-hook 'window-configuration-change-hook #'update-terminal-title)

(with-eval-after-load 'project
  (register-projects-directory "~/Documents/projects"))

;; magit! magit! magit!
(unless (package-installed-p 'magit)
  (package-install 'magit))

;; scope lines
(unless (package-installed-p 'indent-bars)
  (package-install 'indent-bars))
(use-package indent-bars
  :hook ((python-mode yaml-mode go-mode lua-mode nix-mode bash-mode sh-mode lua-ts-mode) . indent-bars-mode))

;; rainbow gamer vomit ultra nacho supreme
(unless (package-installed-p 'rainbow-mode)
  (package-install 'rainbow-mode))
(define-globalized-minor-mode global-rainbow-mode rainbow-mode
  (lambda () (rainbow-mode 1)))
(global-rainbow-mode 1)

;; gitgutter
(unless (package-installed-p 'git-gutter)
  (package-install 'git-gutter))
(global-git-gutter-mode +1)

;; buffer-move
(unless (package-installed-p 'buffer-move)
  (package-install 'buffer-move))
(require 'buffer-move)

;; flycheck
(unless (package-installed-p 'flycheck)
  (package-install 'flycheck))
(add-hook 'after-init-hook #'global-flycheck-mode)

;; this provides the popups when the cursor is over a flycheck-highlighted region
(unless (package-installed-p 'flycheck-popup-tip)
  (package-install 'flycheck-popup-tip))
(flycheck-popup-tip-mode +1)

;; pretty bar
(unless (package-installed-p 'doom-modeline)
  (package-install 'doom-modeline))
(doom-modeline-mode 1)
(setq doom-modeline-total-line-number 1)
(setq doom-modeline-major-mode-color-icon nil)

;; which-key
(unless (package-installed-p 'which-key)
  (package-install 'which-key))
(which-key-mode 1)

;; hl-todo
(unless (package-installed-p 'hl-todo)
  (package-install 'hl-todo))
(global-hl-todo-mode)

;; evil mode
(unless (package-installed-p 'evil)
  (package-install 'evil))
(require 'evil)
(evil-set-undo-system 'undo-redo)
(evil-mode 1)
(unless (package-installed-p 'evil-collection)
  (package-install 'evil-collection))
(evil-collection-init)

(add-hook 'evil-visual-state-entry-hook ;; this disables global-hl-line-mode when entering visual mode to improve the clarity of selection
          (lambda () (global-hl-line-mode -1)))

(add-hook 'evil-visual-state-exit-hook ;; same as above but reenable upon leaving visual mode
          (lambda () (global-hl-line-mode 1)))

(evil-define-key 'normal org-mode-map (kbd "RET") #'org-open-at-point) ;; this is necessary so i can open links and stuff in org docs

(with-eval-after-load 'evil
  (evil-define-key 'normal org-mode-map (kbd "TAB") #'org-cycle)) ;; expanding org headers in normal mode

;; general
(unless (package-installed-p 'general)
  (package-install 'general))
(general-evil-setup)
(general-override-mode 1)

;; language support
(unless (package-installed-p 'go-mode)
  (package-install 'go-mode))

(unless (package-installed-p 'lua-mode)
  (package-install 'lua-mode))

(unless (package-installed-p 'nix-mode)
  (package-install 'nix-mode))

;; dired
(recentf-mode 1)
(setq recentf-max-saved-items 50)

;; buffer settings
(setq ibuffer-auto-mode t) ;; automatically refresh buffer list when visiting it
(add-hook 'ibuffer-mode-hook #'ibuffer-auto-mode)

;; configure general
(general-create-definer spacebinds/leader-keys
  :states '(normal insert visual emacs)
  :keymaps 'override
  :prefix "SPC"
  :global-prefix "M-SPC")

;; configure spacebinds
(spacebinds/leader-keys
 ;; buffer binds
 "b" '(:ignore t :wk "buffer")
 "bb" '(switch-to-buffer :wk "Switch buffer")
 "bi" '(ibuffer :wk "Ibuffer")
 "bk" '(kill-current-buffer :wk "Kill this buffer")
 "bn" '(next-buffer :wk "Next buffer")
 "bp" '(previous-buffer :wk "Previous buffer")
 "br" '(revert-buffer :wk "Reload buffer")
 "bx" '((lambda () (interactive) (kill-current-buffer) (evil-window-delete)) :wk "Buffer nuke")

 ;; window binds
 "w" '(:ignore t :wk "Windows")
 ;; window splits
 "wc" '(evil-window-delete :wk "Close window")
 "wn" '(evil-window-new :wk "New window")
 "ws" '(evil-window-split :wk "Horizontal split window")
 "wv" '(evil-window-vsplit :wk "Vertical split window")

 ;; window motions
 "w <left>" '(evil-window-left :wk "Window left")
 "w <down>" '(evil-window-down :wk "Window down")
 "w <up>" '(evil-window-up :wk "Window up")
 "w <right>" '(evil-window-right :wk "Window right")
 "ww" '(evil-window-next :wk "Goto next window")

 ;; more window motions but for hjkl
 "wh" '(evil-window-left :wk "Window left")
 "wj" '(evil-window-down :wk "Window down")
 "wk" '(evil-window-up :wk "Window up")
 "wl" '(evil-window-right :wk "Window right")

 ;; move windows
 "wH" '(buf-move-left :wk "Buffer move left")
 "wJ" '(buf-move-down :wk "Buffer move down")
 "wK" '(buf-move-up :wk "Buffer move up")
 "wL" '(buf-move-right :wk "Buffer move right")
 
 ;; toggle binds
 "t" '(:ignore t :wk "Toggle")
 "tl" '(display-line-numbers-mode :wk "Toggle line numbers")
 "tt" '(visual-line-mode :wk "Toggle truncated lines")

 ;; dired
 "d" '(:ignore t :wk "Dired")
 "dj" '(dired-jump :wk "Dired jump to current")
 "dp" '((lambda () (interactive) (dired "~/Documents/projects")) :wk "Dired jump to projects")
 "dr" `(recentf-open-files :wk "Dired recently opened files")
 "dn" `(dired-create-empty-file :wk "Dired create empty file")
 "df" `(dired-create-directory :wk "Dired create directory")
 "dd" `(dired-do-delete :wk "Dired delete selection")
 "do" `(dired :wk "Open dired")

 ;; magit
 "g" '(:ignore t :wk "Magit")
 "gg" '(magit-status :wk "Magit status")

 ;; bookmarks
 "m" '(:ignore t :wk "Bookmarks")
 "mm" '(bookmark-set :wk "Set bookmark")
 "mj" '(bookmark-jump :wk "Jump to bookmark")
 "ml" '(bookmark-bmenu-list :wk "List bookmarks")

 ;; org
 "o" '(:ignore t :wk "Org")
 "oe" '(org-export-dispatch :wk "Org export")
 "ol" '(org-insert-link :wk "Org insert link")
 "oL" '(org-toggle-link-display :wk "Toggle raw links")
 "of" '(org-shifttab :wk "Global fold/unfold")
 
 ;; miscellaneous
 "." '(find-file :wk "Find file")
 "TAB TAB" '(comment-line :wl "Comment lines")
 "bd" '(dashboard-open :wk "Open dashboard")
)

;; allows me to hit escape twice to exit M-x as opposed to using C-g
(global-set-key (kbd "ESC <escape>") (kbd "C-g"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-default nil)
 '(create-lockfiles nil)
 '(custom-safe-themes
   '("4b53f1da21cbd4e649ad3328f38798efb1473a21132e0fe6407b34751cf8c0b0"
     default))
 '(delete-auto-save-files t)
 '(find-file-visit-truename t)
 '(large-file-warning-threshold nil)
 '(make-backup-files nil)
 '(package-selected-packages nil))

(electric-pair-mode 1) ;; auto pairs
(setq-default electric-indent-chars '(?\n ?\^?)) ;; triggered by only newlines and del
;;(electric-indent-mode -1) ;; disable indenting

;; hungry delete
(defun backward-delete-column-wise ()
  "Delete 4 spaces if preceded by 4 spaces, otherwise delete 1 character."
  (interactive)
  (let ((column (current-column)))
    (if (and (not (bolp)) ; not at the beginning of the line
             (> column 0)
             ;; check if the previous 4 characters are spaces
             (string= (buffer-substring-no-properties
                       (max (point-min) (- (point) 4)) (point))
                      "    ")
             ;; ensure we are at a 4-space tab stop
             (zerop (% column 4)))
        (delete-char -4)
      (delete-char -1))))

(add-hook 'c-mode-hook
    (lambda ()
        (local-set-key (kbd "DEL") 'backward-delete-column-wise)))

;; bind it to the backspace key
(global-set-key (kbd "DEL") 'backward-delete-column-wise)

;; visual tweaks
(menu-bar-mode -1)
(tool-bar-mode -1)
(global-hl-line-mode 1)

(global-display-line-numbers-mode 1)
(global-visual-line-mode t)

(set-face-attribute 'font-lock-comment-face nil
    :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil
    :slant 'italic)
(setq-default line-spacing 0.15)

;; set terminal background on startup to get rid of the border, restore on close
(defun set-terminal-bg (color &optional frame)
  (let ((frame (or frame (selected-frame))))
    (unless (display-graphic-p frame)
      (send-string-to-terminal
       (format "\033]11;%s\033\\" color)
       frame))))

(defun reset-terminal-bg (&optional frame)
  (let ((frame (or frame (selected-frame))))
    (unless (display-graphic-p frame)
      (send-string-to-terminal "\033]111\033\\" frame))))

;; when a new client frame is created
(add-hook 'server-after-make-frame-hook
          (lambda () (set-terminal-bg "#060606"))) ;; this doesn't match my theme because i use xterm-256color on foot so the colors end up a little bit different

;; when emacsclient finishes
(add-hook 'server-done-hook
          (lambda () (reset-terminal-bg)))

;; without this, since im using evil mode, :q will not trigger a reset to my original terminal background color
(evil-ex-define-cmd "q" (lambda ()
                          (interactive)
                          (reset-terminal-bg)
                          (save-buffers-kill-terminal)))

(evil-ex-define-cmd "wq" (lambda ()
                           (interactive)
                           (save-buffer)
                           (reset-terminal-bg)
                           (save-buffers-kill-terminal)))

;; actually scroll instead of changing pages
(setq scroll-margin 6 ;; space at the bottom of the buffer when EOF is reached
      scroll-conservatively 101)
(setq next-line-add-newlines nil)

;; fuck tab characters
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default standard-indent 4)
(setq-default c-basic-offset 4)

;; god dammit fuck tab characters AND 8 space tabs
(defun fixtabs-go-mode-hook ()
  (setq indent-tabs-mode nil)
  (setq tab-width 4)
  (setq go-tab-width 4))

(add-hook 'go-mode-hook 'fixtabs-go-mode-hook)

;; disable resize frames since we're TUI only
(setq frame-inhibit-implied-resize t)

;; y/n instead of yes/no
(setq read-answer-short t)
(if (boundp 'use-short-answers)
    (setq use-short-answers t)
  (advice-add 'yes-or-no-p :override #'y-or-n-p))

;; update less often
(setq which-func-update-delay 1.0)

;; wrap on whitespace instead of in the middle of a word
(setq-default word-wrap t)

;; keep track of cursor position in files
(save-place-mode 1)

;; emacsclient file.xyz should persist in the buffer list
(setq server-kill-new-buffers nil)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'bummer t)

;; restore gc to controlled values
(setq gc-cons-threshold 100000000)
(setq read-process-output-max 1048576)

(provide `init)

;;; init.el ends here
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
