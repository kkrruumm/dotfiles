;;; tools.el --- -*- lexical-binding: t -*-
;;; Commentary:

;;; Code:

;; magit! magit! magit!
(unless (package-installed-p 'magit)
  (package-install 'magit))

;; this is so emacs can annoy me as opposed to other people doing it
(unless (package-installed-p 'flycheck)
  (package-install 'flycheck))
(add-hook 'after-init-hook #'global-flycheck-mode)

;; popups in the editor
(unless (package-installed-p 'flycheck-popup-tip)
  (package-install 'flycheck-popup-tip))
(flycheck-popup-tip-mode +1)

;; where have i been
(unless (package-installed-p 'git-gutter)
  (package-install 'git-gutter))
(global-git-gutter-mode +1)

;; scope lines
(unless (package-installed-p 'indent-bars)
  (package-install 'indent-bars))
(use-package indent-bars
  :hook ((python-mode yaml-mode go-mode lua-mode nix-mode
          bash-mode sh-mode lua-ts-mode) . indent-bars-mode))

;; rainbow gamer vomit ultra nacho supreme
(unless (package-installed-p 'rainbow-mode)
  (package-install 'rainbow-mode))
(define-globalized-minor-mode global-rainbow-mode rainbow-mode
  (lambda () (rainbow-mode 1)))
(global-rainbow-mode 1)

(unless (package-installed-p 'buffer-move)
  (package-install 'buffer-move))
(require 'buffer-move)

;; idk which one is it
(unless (package-installed-p 'which-key)
  (package-install 'which-key))
(which-key-mode 1)

(unless (package-installed-p 'hl-todo)
  (package-install 'hl-todo))
(global-hl-todo-mode)

;; just using my window manager for this but leaving this here for later
;; requires cmake and libvterm-dev (apt install cmake libvterm-dev)
;; compiles a native module on first load
;; (unless (package-installed-p 'vterm)
;;   (package-install 'vterm))

;; (defun open-vterm-split ()
;;   "Open a vterm terminal in a horizontal split below."
;;   (interactive)
;;   (let ((height (/ (window-total-height) 3)))
;;     (split-window-below (- (window-total-height) height))
;;     (other-window 1)
;;     (vterm)))

(provide 'tools)
;;; tools.el ends here
