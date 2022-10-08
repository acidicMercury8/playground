﻿// This file was auto-generated by ML.NET Model Builder.
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.ML.Data;
using Microsoft.ML.Trainers.FastTree;
using Microsoft.ML.Trainers;
using Microsoft.ML;

namespace TitanicSurvivalRegression
{
    public partial class TitanicModel
    {
        /// <summary>
        /// Retrains model using the pipeline generated as part of the training process. For more information on how to load data, see aka.ms/loaddata.
        /// </summary>
        /// <param name="mlContext"></param>
        /// <param name="trainData"></param>
        /// <returns></returns>
        public static ITransformer RetrainPipeline(MLContext mlContext, IDataView trainData)
        {
            var pipeline = BuildPipeline(mlContext);
            var model = pipeline.Fit(trainData);

            return model;
        }

        /// <summary>
        /// build the pipeline that is used from model builder. Use this function to retrain model.
        /// </summary>
        /// <param name="mlContext"></param>
        /// <returns></returns>
        public static IEstimator<ITransformer> BuildPipeline(MLContext mlContext)
        {
            // Data process configuration with pipeline data transformations
            var pipeline = mlContext.Transforms.ReplaceMissingValues(new []{new InputOutputColumnPair(@"Pclass", @"Pclass"),new InputOutputColumnPair(@"Age", @"Age"),new InputOutputColumnPair(@"SibSp", @"SibSp"),new InputOutputColumnPair(@"Parch", @"Parch"),new InputOutputColumnPair(@"Fare", @"Fare")})      
                                    .Append(mlContext.Transforms.Text.FeaturizeText(inputColumnName:@"Gender",outputColumnName:@"Gender"))      
                                    .Append(mlContext.Transforms.Text.FeaturizeText(inputColumnName:@"Embarked",outputColumnName:@"Embarked"))      
                                    .Append(mlContext.Transforms.Concatenate(@"Features", new []{@"Pclass",@"Age",@"SibSp",@"Parch",@"Fare",@"Gender",@"Embarked"}))      
                                    .Append(mlContext.Regression.Trainers.FastForest(new FastForestRegressionTrainer.Options(){NumberOfTrees=55,NumberOfLeaves=6,FeatureFraction=1F,LabelColumnName=@"Survived",FeatureColumnName=@"Features"}));

            return pipeline;
        }
    }
}
