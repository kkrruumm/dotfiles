;;; editing.el --- -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; auto pairs
(electric-pair-mode 1)
(setq-default electric-indent-chars '(?\n ?\^?))

;; indent/tabbing shit
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default standard-indent 4)
(setq-default c-basic-offset 4)

(setq-default word-wrap t)

;; spellcheck
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'find-file-hook
          (lambda ()
            (when (eq major-mode 'fundamental-mode)
              (flyspell-mode 1))))
;; spellcheck comments and strings in code
;; (add-hook 'prog-mode-hook 'flyspell-prog-mode)

;; deletes 4 spaces at once when at a tab stop, otherwise deletes 1
(defun backward-delete-column-wise ()
  "Delete 4 spaces if preceded by 4 spaces at a tab stop, otherwise delete 1 character."
  (interactive)
  (let ((column (current-column)))
    (if (and (not (bolp))
             (> column 0)
             (string= (buffer-substring-no-properties
                       (max (point-min) (- (point) 4)) (point))
                      "    ")
             (zerop (% column 4)))
        (delete-char -4)
      (delete-char -1))))

(global-set-key (kbd "DEL") 'backward-delete-column-wise)
(add-hook 'c-mode-hook
          (lambda ()
            (local-set-key (kbd "DEL") 'backward-delete-column-wise)))

(provide 'editing)
;;; editing.el ends here
