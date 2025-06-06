;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Lucas Pruvost"
      user-mail-address "lucas.pruvost@protonmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-tokyo-night)   ; doom-one doom-tokyo-night doom-moonlight

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(after! projectile
  (setq projectile-project-search-path '("~/Projects")))

(use-package! web-mode
  :mode
  (("\\.jsx\\'" . web-mode)
   ("\\.ts\\'" . web-mode)
   ("\\.tsx\\'" . web-mode))

  :config
  ;; Indentation and padding
  (setq web-mode-markup-indent-offset 4
        web-mode-css-indent-offset 4
        web-mode-code-indent-offset 4 ; other scripting / programming languages
        web-mode-script-padding 4 ; left padding inside a <script>
        web-mode-style-padding 4)) ; left padding inside a <style>

;;;;
;;;; KEYBINDINGS
;;;;

;;; Parentheses management
(after! (smartparens evil)
  (map! :map smartparens-mode-map
        "C-)" #'sp-forward-slurp-sexp
        "C-0" #'sp-forward-barf-sexp
        "C-(" #'sp-backward-slurp-sexp
        "C-9" #'sp-backward-barf-sexp
        "M-(" #'sp-wrap-round
        "M-S" #'sp-split-sexp
        "<backtab>" #'sp-backward-up-sexp)

  (map! :map (evil-motion-state-map
              evil-insert-state-map
              comint-mode-map)
        "C-d" #'sp-splice-sexp-killing-around)

  (map! "M-9" #'sp-splice-sexp
        "M-s" #'sp-splice-sexp
        "M-r" #'sp-raise-sexp ; seems to be similar to <C-d> SP-SPLICE-SEXP-KILLING-AROUND
        "M-h" #'sp-backward-kill-sexp
        "M-l" #'sp-kill-sexp
        "M-H" #'sp-backward-kill-word
        "M-L" #'sp-kill-word))

;;; Comments based on Lisp standards
;;; FIXME: Insert ";;;;" instead of ";;;" when selecting multiple top-level lines.
(defun lisp-comment-dwim ()
  "Comment or uncomment using standard Lisp conventions by expanding COMMENT-DWIM."
  (interactive)
  (let* ((depth
          (nth 0 (syntax-ppss)))
         (empty-line?
          (= (line-beginning-position) (line-end-position)))
         (next-line-empty?
          (save-excursion
            (forward-line)
            (= (line-beginning-position) (line-end-position))))
         (top-level?
          (= depth 0)))
    (cond
     ((and top-level? empty-line? next-line-empty?)
      (comment-dwim 4)
      (end-of-line))
     ((and top-level? empty-line?)
      (comment-dwim 3)
      (end-of-line))
     (t
      (comment-dwim nil)))))

(after! (lisp-mode)
  (map! :map lisp-mode-map
        "M-;" #'lisp-comment-dwim))
