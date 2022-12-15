using System;
using System.Linq;
using System.Text;

using Microsoft.Build.Locator;
using Microsoft.CodeAnalysis;
using Microsoft.CodeAnalysis.CSharp;
using Microsoft.CodeAnalysis.CSharp.Syntax;
using Microsoft.CodeAnalysis.MSBuild;

namespace FieldsCountCodeAnalyzer {
    public class Program {
        private static Project GetProjectFromSolution(string solutionPath,
            MSBuildWorkspace workspace) {
            MSBuildLocator.RegisterDefaults();
            var currentSolution = workspace.OpenSolutionAsync(solutionPath).Result;
            return currentSolution.Projects.Single();
        }

        public static void Main(string[] args) {
            if (args.Length == 0) {
                return;
            }

            var solutionPath = args[0];

            var warnings = new StringBuilder();
            const string warningMessageFormat =
                "{0} class at line {1} contains too many fields";

            MSBuildLocator.RegisterDefaults();
            using (var workspace = MSBuildWorkspace.Create()) {
                var currentProject = GetProjectFromSolution(solutionPath, workspace);
                foreach (var document in currentProject.Documents) {
                    var tree = document.GetSyntaxTreeAsync().Result;
                    var classNodes = tree.GetRoot()
                        .DescendantNodesAndSelf()
                        .OfType<ClassDeclarationSyntax>();
                    foreach (var classStatement in classNodes) {
                        var count = classStatement.ChildNodes()
                            .Count(x => x.Kind() == SyntaxKind.FieldDeclaration);
                        if (count > 20) {
                            var className = classStatement.Identifier.ToString();
                            var lineNumber = classStatement.GetLocation()
                                .GetLineSpan()
                                .StartLinePosition.Line + 1;
                            warnings.AppendLine(string.Format(warningMessageFormat,
                                className, lineNumber));
                        }
                    }
                }
            }

            if (warnings.Length != 0) {
                Console.WriteLine(warnings.ToString());
            }
        }
    }
}
