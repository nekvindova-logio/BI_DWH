[StagingDefinition = [Kind = "FastCopy"]]
section Section1;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "table_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared table = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "5e82cc10-1831-42a4-9172-41fe6831634d"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "3fafb301-109b-4540-89e8-0ccd05d5d922"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "table", ItemKind = "Table"]}[Data],
  #"Added index" = Table.AddIndexColumn(#"Navigation 2", "Index", 0, 1, Int64.Type)
in
  #"Added index";
shared table_DataDestination = let
  Pattern = Lakehouse.Contents([HierarchicalNavigation = null, CreateNavigationProperties = false, EnableFolding = false]),
  Navigation_1 = Pattern{[workspaceId = "5e82cc10-1831-42a4-9172-41fe6831634d"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "3fafb301-109b-4540-89e8-0ccd05d5d922"]}[Data],
  TableNavigation = Navigation_2{[Id = "table_2", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
