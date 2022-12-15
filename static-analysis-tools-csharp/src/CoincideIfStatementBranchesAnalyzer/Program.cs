using System.IO;
using System.Linq;
using System.Text;

using Microsoft.Build.Locator;
using Microsoft.CodeAnalysis;
using Microsoft.CodeAnalysis.CSharp;
using Microsoft.CodeAnalysis.CSharp.Syntax;
using Microsoft.CodeAnalysis.MSBuild;

namespace CoincideIfStatementBranchesAnalyzer {
    public class Program {
        public class IfWalker : CSharpSyntaxWalker {
            public StringBuilder Warnings { get; } = new StringBuilder();

            const string WarningMessageFormat =
                "'if' with equal 'then' and 'else' blocks is found in file {0} at line {1}";

            public static bool ApplyRule(IfStatementSyntax ifStatement) {
                if (ifStatement?.Else == null) {
                    return false;
                }

                var thenBody = ifStatement.Statement;
                var elseBody = ifStatement.Else.Statement;
                return SyntaxFactory.AreEquivalent(thenBody, elseBody);
            }

            public override void VisitIfStatement(IfStatementSyntax node) {
                if (ApplyRule(node)) {
                    var lineNumber = node.GetLocation()
                        .GetLineSpan()
                        .StartLinePosition.Line + 1;
                    Warnings.AppendLine(string.Format(WarningMessageFormat,
                        node.SyntaxTree.FilePath, lineNumber));
                }

                base.VisitIfStatement(node);
            }
        }

        private static Project GetProjectFromSolution(string solutionPath,
            MSBuildWorkspace workspace) {
            MSBuildLocator.RegisterDefaults();
            var currentSolution = workspace.OpenSolutionAsync(solutionPath).Result;
            return currentSolution.Projects.Single();
        }

        public static void StartWalker(IfWalker ifWalker, SyntaxNode syntaxNode) {
            ifWalker.Warnings.Clear();
            ifWalker.Visit(syntaxNode);
        }

        public static void Main(string[] args) {
            if (args.Length != 2) {
                return;
            }

            var solutionPath = args[0];
            var logPath = args[1];

            MSBuildLocator.RegisterDefaults();

            using (var workspace = MSBuildWorkspace.Create()) {
                var currentProject = GetProjectFromSolution(solutionPath, workspace);
                foreach (var document in currentProject.Documents) {
                    var tree = document.GetSyntaxTreeAsync().Result;
                    var ifWalker = new IfWalker();
                    StartWalker(ifWalker, tree.GetRoot());

                    var warnings = ifWalker.Warnings;
                    if (warnings.Length != 0) {
                        File.AppendAllText(logPath, warnings.ToString());
                    }
                }
            }
        }
    }
}
