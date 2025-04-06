# dbt-Exposures
Define and describe downstream uses of your dbt project

Exposure are define under the ```exposure``` key under the YAML file. Usually under 
```models/exposures/```

```yaml
# models/exposures.yml

version: 2

exposures:
  - name: Orders_data
    label: Orders_data
    type: notebook
    maturity: high
    url: https://tinyurl.com/jaffle-shop-reporting
    description: 'Expsosure for orders metrics'
    depends_on:
      - ref('fct_orders')
      - metric('order_total')
      - metric('large_orders')
      - metric('cumulative_order_amount_mtd')
    owner:
      name: Michael McData
      email: data@jaffleshop.com
  
  - name: Customers_data
    label: Customers_data
    type: notebook
    maturity: high
    url: https://tinyurl.com/jaffle-shop-reporting
    description: 'Exposure for customer metrics'
    depends_on:
      - ref('dim_customers')
    owner: 
      name: Data Startrek
      email: operations_manager@enterprise.com

```

Key components of this exposure:
1. `name`: Identifier for the exposure
2. `label`: Human-readable name for the exposure
3. `type`: What kind of exposure this is (dashboard, application, etc.)
4. `maturity`: The maturity level of the exposure
5. `owner`: Who maintains this exposure
6. `depends_on`: Which DBT models and metrics this exposure relies on
7. `description`: Business purpose of the exposure
8. `meta`: Additional metadata about the exposure
9. `url`: The URL where the exposure can be accessed

This YAML file would typically be placed in your `models` directory alongside your model definitions. The exposure helps document downstream uses of your data models and creates lineage in your documentation.

By defining exposures, you establish a clear lineage from your raw data to its downstream end-use cases. Defining exposures allows you to:

- **Visualize** the downstream resources and processes in your global lineage.
- **Run, test, and list** resources that feed into your exposure.
- **Populate** a dedicated page in your documentation (on the docs site and in Explorer) with context relevant to data consumers.

Exposures are configured in `.yml` files inside your `models/` directory. Once configured, an exposure will appear as a node in your lineage graph. Exposures can reference models, metrics, and sources, although we advise against referencing sources in exposures.

- To run all nodes upstream of an exposure, use the command: `dbt run --select +exposure:my_exposure_name`
- To run all nodes upstream of all exposures, use the command: `dbt run --select +exposure:*`

You can view exposures in the docs site after running the command `dbt docs generate`. Additionally, you can view exposures configured in your main branch in dbt Explorer after successfully running a production job.