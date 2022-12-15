using System.Linq;
using System.Text;

using Microsoft.Build.Locator;
using Microsoft.CodeAnalysis;
using Microsoft.CodeAnalysis.CSharp;
using Microsoft.CodeAnalysis.CSharp.Syntax;
using Microsoft.CodeAnalysis.MSBuild;

namespace CoincideIfStatementBranchesAnalyzer {
    public class Program {
        private static Project GetProjectFromSolution(string solutionPath,
            MSBuildWorkspace workspace) {
            MSBuildLocator.RegisterDefaults();
            var currentSolution = workspace.OpenSolutionAsync(solutionPath).Result;
            return currentSolution.Projects.Single();
        }

        private static bool ApplyRule(IfStatementSyntax ifStatement) {
            if (ifStatement?.Else == null) {
                return false;
            }

            var thenBody = ifStatement.Statement;
            var elseBody = ifStatement.Else.Statement;
            return SyntaxFactory.AreEquivalent(thenBody, elseBody);
        }

        public static void Main(string[] args) {
            if (args.Length != 2) {
                return;
            }

            var solutionPath = args[0];
            var logPath = args[1];

            var warnings = new StringBuilder();
            const string warningMessageFormat =
                "'if' with equal 'then' and 'else' blocks is found in file {0} at line {1}";

            MSBuildLocator.RegisterDefaults();

            using (var workspace = MSBuildWorkspace.Create()) {
                var currentProject = GetProjectFromSolution(solutionPath, workspace);
                foreach (var document in currentProject.Documents) {
                    var tree = document.GetSyntaxTreeAsync().Result;
                    var ifStatementNodes = tree.GetRoot()
                        .DescendantNodesAndSelf()
                        .OfType<IfStatementSyntax>();
                    foreach (var ifStatement in ifStatementNodes) {
                        if (ApplyRule(ifStatement)) {
                            var lineNumber = ifStatement.GetLocation()
                                .GetLineSpan()
                                .StartLinePosition.Line + 1;
                            warnings.AppendLine(string.Format(warningMessageFormat,
                                document.FilePath, lineNumber));
                        }
                    }
                }
            }
        }
    }
}
