[StagingDefinition = [Kind = "FastCopy"]]
section Section1;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "table_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared table = let
  Source = Excel.Workbook(Web.Contents("https://czlogio-my.sharepoint.com/personal/nekvindova_logio_cz/Documents/movement_type.xlsx"), null, true),
  #"Navigation 1" = Source{[Item = "List1", Kind = "Sheet"]}[Data],
  #"Changed column type" = Table.TransformColumnTypes(#"Navigation 1", {{"Column2", type text}, {"Column3", type text}, {"Column4", type text}, {"Column5", type text}}),
  #"Promoted headers" = Table.PromoteHeaders(#"Changed column type", [PromoteAllScalars = true]),
  #"Removed columns" = Table.RemoveColumns(#"Promoted headers", {"sign"})
in
  #"Removed columns";
shared table_DataDestination = let
  Pattern = Lakehouse.Contents([CreateNavigationProperties = false, EnableFolding = false]),
  Navigation_1 = Pattern{[workspaceId = "5e82cc10-1831-42a4-9172-41fe6831634d"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "3fafb301-109b-4540-89e8-0ccd05d5d922"]}[Data],
  TableNavigation = Navigation_2{[Id = "table", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
