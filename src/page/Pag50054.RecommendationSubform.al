page 50054 "Recommendation Subform"
{
    Caption = 'Recommendations';
    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Incident Line";
    SourceTableView = where(Type = const(Recommendation), "Document Type" = const("Incident Notification Form"));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Responsible Party"; Rec."Responsible Party")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Responsible Party field.', Comment = '%';
                }
            }
        }
    }
}