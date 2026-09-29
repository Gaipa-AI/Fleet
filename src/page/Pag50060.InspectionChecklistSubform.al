page 50060 "Inspection Checklist Subform"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Form Line";
    SourceTableView = where("Document Type" = const("Equipment Inspection"));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field(Details; Rec.Details)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Details field.', Comment = '%';
                }
                
                // field(Present; Rec.Present)
                // {
                //     Caption = 'Good';
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies if that vehicle part is okay or good to go', Comment = '%';

                // }
                field(Mon; Rec.Mon)
                {
                    Caption = 'Monday';
                    ApplicationArea = All;
                    ToolTip = 'Specifies if that vehicle part is okay or good to go', Comment = '%';

                }
                field(Tue; Rec.Tue)
                {
                    Caption = 'Tuesday';
                    ApplicationArea = All;
                    ToolTip = 'Specifies if that vehicle part is okay or good to go', Comment = '%';
                }
                field(Wed; Rec.Wed)
                {
                    Caption = 'Wednesday';
                    ApplicationArea = All;
                    ToolTip = 'Specifies if that vehicle part is okay or good to go', Comment = '%';
                }
                field(Thur; Rec.Thurs)
                {
                    Caption = 'Thursday';
                    ApplicationArea = All;
                    ToolTip = 'Specifies if that vehicle part is okay or good to go', Comment = '%';
                }
                field(Fri; Rec.Fri)
                {
                    Caption = 'Friday';
                    ApplicationArea = All;
                    ToolTip = 'Specifies if that vehicle part is okay or good to go', Comment = '%';
                }
                field(Sat; Rec.Sat)
                {
                    Caption = 'Saturday';
                    ApplicationArea = All;
                    ToolTip = 'Specifies if that vehicle part is okay or good to go', Comment = '%';
                }
                field(Sun; Rec.Sun)
                {
                    Caption = 'Sunday';
                    ApplicationArea = All;
                    ToolTip = 'Specifies if that vehicle part is okay or good to go', Comment = '%';
                }
                // field(Fair;Rec.Fair)
                // {
                //     Caption = 'Fair';
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies if that vehicle part is fair', Comment = '%';
                // }

                // field(Missing; Rec.Missing)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies if that vehicle part is missing and needed to be replaced', Comment = '%';

                // }

                // field(Damaged; Rec.Damaged)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies if that part of the vehicle is damaged or poor', Comment = '%';

                // 

                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Comment field.', Comment = '%';
                }
            }
        }
    }
}