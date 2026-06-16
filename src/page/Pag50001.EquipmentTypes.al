page 50001 "Equipment Types"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "General value";
    SourceTableView = where(Type = filter('Equipment Type'));
    Caption = 'Equipment Types';
    layout
    {
        area(Content)
        {
            repeater(List)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    Caption = 'Code';
                    ToolTip = 'Specifies the code for the equipment type.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Description';
                    ToolTip = 'Specifies a description for the equipment type.';
                }
            }
        }
    }
}