package tree_sitter_edl_test

import (
	"testing"

	tree_sitter "github.com/smacker/go-tree-sitter"
	"github.com/tree-sitter/tree-sitter-edl"
)

func TestCanLoadGrammar(t *testing.T) {
	language := tree_sitter.NewLanguage(tree_sitter_edl.Language())
	if language == nil {
		t.Errorf("Error loading Edl grammar")
	}
}
