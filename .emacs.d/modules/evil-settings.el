;;; evil-settings.el --- -*- lexical-binding: t -*-
;;; Commentary:

;;; Code:

(unless (package-installed-p 'evil)
  (package-install 'evil))
(setq evil-want-keybinding nil)
(require 'evil)
(evil-set-undo-system 'undo-redo)
(evil-mode 1)

(unless (package-installed-p 'evil-collection)
  (package-install 'evil-collection))
(evil-collection-init)

;; disabling hl-line in visual mode
(add-hook 'evil-visual-state-entry-hook (lambda () (global-hl-line-mode -1)))
(add-hook 'evil-visual-state-exit-hook  (lambda () (global-hl-line-mode 1)))

(evil-define-key 'normal org-mode-map (kbd "RET") #'org-open-at-point)
(with-eval-after-load 'evil
  (evil-define-key 'normal org-mode-map (kbd "TAB") #'org-cycle))

;; without these, evil's :q skips reset-terminal-bg
(evil-ex-define-cmd "q" (lambda ()
                          (interactive)
                          (reset-terminal-bg)
                          (save-buffers-kill-terminal)))

(evil-ex-define-cmd "qa" (lambda ()
                           (interactive)
                           (reset-terminal-bg)
                           (save-buffers-kill-terminal)))

(evil-ex-define-cmd "wq" (lambda ()
                           (interactive)
                           (save-buffer)
                           (reset-terminal-bg)
                           (save-buffers-kill-terminal)))

(evil-ex-define-cmd "wqa" (lambda ()
                           (interactive)
                           (save-buffer)
                           (reset-terminal-bg)
                           (save-buffers-kill-terminal)))
(provide 'evil-settings)
;;; evil-settings.el ends here
