﻿namespace ContosoUniversity.Features.Department
{
    using System;
    using System.ComponentModel.DataAnnotations;
    using System.Linq;
    using DataAccess;
    using Infrastructure;
    using Microsoft.Data.Entity;
    using Models;
    using Newtonsoft.Json;

    public class Details
    {
        public class Query : DetailsQuery<QueryResponse>
        {
            public Query(int id) : base(id)
            {
            }
        }

        public class QueryResponse
        {
            [JsonProperty("id")]
            public int Id { get; set; }

            [JsonProperty("administratorFullName")]
            [Display(Name = "Administrator")]
            public string AdministratorFullName { get; set; }

            [JsonProperty("name")]
            public string Name { get; set; }

            [JsonProperty("budget")]
            public decimal Budget { get; set; }

            [JsonProperty("startDate")]
            [Display(Name = "Start Date")]
            public DateTime? StartDate { get; set; }
        }

        public class QueryHandler : DetailsQueryHandler<Department, Query, QueryResponse>
        {
            public QueryHandler(ContosoUniversityContext dbContext) : base(dbContext)
            {
            }

            protected override IQueryable<Department> ModifyQuery(IQueryable<Department> query)
            {
                return query.Include(x => x.Administrator);
            }
        }
    }
}